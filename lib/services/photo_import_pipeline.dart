import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:crypto/crypto.dart';
import '../data/database/database.dart';
import '../data/repositories/photo_repository.dart';
import 'photo_scanner_service.dart';
import 'directory_watcher_service.dart';

/// Result of a single photo import through the pipeline.
class PhotoImportResult {
  const PhotoImportResult({
    required this.filePath,
    required this.success,
    this.photo,
    this.error,
    this.skippedDuplicate = false,
  });

  final String filePath;
  final bool success;
  final Photo? photo;
  final String? error;
  final bool skippedDuplicate;
}

/// Orchestrates the full import pipeline when a new file is detected
/// by the [DirectoryWatcherService]:
///
/// 1. Compute SHA-256 hash for deduplication
/// 2. Skip if duplicate
/// 3. Create [ScanResult] and persist to database via [PhotoScannerService]
/// 4. Run AI categorization (YOLO-NAS + MobileNetV3)
/// 5. Write sidecar `.photo.json`
/// 6. Emit [PhotoImportResult] on [importStream]
///
/// Files are processed sequentially to avoid CPU overload from TFLite.
class PhotoImportPipeline {
  PhotoImportPipeline({
    required this.scannerService,
    required this.repository,
  });

  final PhotoScannerService scannerService;
  final PhotoRepository repository;

  final StreamController<PhotoImportResult> _importController =
      StreamController<PhotoImportResult>.broadcast();

  /// Stream that emits the result of each imported photo.
  Stream<PhotoImportResult> get importStream => _importController.stream;

  /// Whether a batch import is currently in progress.
  bool _isProcessing = false;
  bool get isProcessing => _isProcessing;

  /// Queue of pending file paths (for FIFO processing).
  final List<String> _pendingFiles = [];

  // -----------------------------------------------------------------------
  // Public API
  // -----------------------------------------------------------------------

  /// Import a single file detected by the watcher.
  ///
  /// If another import is in progress, the file is queued and processed
  /// sequentially.
  Future<void> importFile(String filePath) async {
    debugPrint('[PhotoImportPipeline] importFile called: $filePath');
    if (_isProcessing) {
      debugPrint('[PhotoImportPipeline] Already processing, queuing: $filePath');
      if (!_pendingFiles.contains(filePath)) {
        _pendingFiles.add(filePath);
      }
      return;
    }

    await _processFile(filePath);

    // Drain the queue.
    while (_pendingFiles.isNotEmpty) {
      final next = _pendingFiles.removeAt(0);
      await _processFile(next);
    }
  }

  /// Import a batch of files (e.g., from a manual folder scan) without
  /// emitting per-file results on the stream. Returns the count of
  /// successfully imported files.
  Future<int> importBatch(List<String> filePaths) async {
    int imported = 0;
    for (final path in filePaths) {
      final result = await _processFile(path, emitResult: false);
      if (result != null && result.success) {
        imported++;
      }
    }
    return imported;
  }

  /// Dispose the stream controller.
  void dispose() {
    if (!_importController.isClosed) {
      _importController.close();
    }
  }

  // -----------------------------------------------------------------------
  // Private
  // -----------------------------------------------------------------------

  Future<PhotoImportResult?> _processFile(
    String filePath, {
    bool emitResult = true,
  }) async {
    _isProcessing = true;
    debugPrint('[PhotoImportPipeline] Processing: $filePath');

    try {
      // 1. Verify the file still exists and is a regular file.
      final file = File(filePath);
      if (!await file.exists()) {
        debugPrint('[PhotoImportPipeline] File no longer exists: $filePath');
        final result = PhotoImportResult(
          filePath: filePath,
          success: false,
          error: 'File no longer exists',
        );
        if (emitResult) _emit(result);
        _isProcessing = false;
        return result;
      }

      // 2. Compute SHA-256 hash.
      final hash = await _computeSha256(filePath);
      debugPrint('[PhotoImportPipeline] Hash computed: ${hash.substring(0, 16)}...');

      // 3. Deduplication check.
      final existing = await repository.findDuplicateByHash(hash);
      if (existing != null) {
        debugPrint('[PhotoImportPipeline] Duplicate found, skipping: $filePath');
        final result = PhotoImportResult(
          filePath: filePath,
          success: false,
          skippedDuplicate: true,
        );
        if (emitResult) _emit(result);
        _isProcessing = false;
        return result;
      }

      // 4. Read file metadata.
      final fileStat = await file.stat();
      final ext =
          p.extension(filePath).toLowerCase().replaceAll('.', '');

      // 5. Build ScanResult and persist.
      final scanResult = ScanResult(
        path: filePath,
        filename: p.basename(filePath),
        mediaType: _isVideo(ext) ? MediaType.video : MediaType.photo,
        sha256Hash: hash,
        sizeBytes: fileStat.size,
        format: ext,
        takenAt: fileStat.modified,
      );

      debugPrint('[PhotoImportPipeline] Persisting to DB: ${scanResult.filename}');
      await scannerService.persistScanResult(scanResult);

      // 6. Look up the persisted photo by hash.
      final photo = await repository.findDuplicateByHash(hash);
      if (photo == null) {
        debugPrint('[PhotoImportPipeline] Failed to retrieve persisted photo');
        final result = PhotoImportResult(
          filePath: filePath,
          success: false,
          error: 'Failed to retrieve persisted photo',
        );
        if (emitResult) _emit(result);
        _isProcessing = false;
        return result;
      }

      // 7. Run AI categorization with a timeout — never block the import.
      debugPrint('[PhotoImportPipeline] Running AI categorization for: ${photo.filename}');
      try {
        await repository
            .categorizeAndPersist(photo)
            .timeout(const Duration(seconds: 30));
        debugPrint('[PhotoImportPipeline] AI categorization completed');
      } catch (e) {
        debugPrint(
            '[PhotoImportPipeline] AI categorization failed/timed out for '
            '${photo.filename}: $e');
      }

      final result = PhotoImportResult(
        filePath: filePath,
        success: true,
        photo: photo,
      );
      debugPrint('[PhotoImportPipeline] SUCCESS: ${photo.filename}');
      if (emitResult) _emit(result);
      _isProcessing = false;
      return result;
    } catch (e) {
      debugPrint('[PhotoImportPipeline] ERROR: $filePath — $e');
      final result = PhotoImportResult(
        filePath: filePath,
        success: false,
        error: e.toString(),
      );
      if (emitResult) _emit(result);
      _isProcessing = false;
      return result;
    }
  }

  void _emit(PhotoImportResult result) {
    if (!_importController.isClosed) {
      _importController.add(result);
    }
  }

  /// Compute SHA-256 hash of a file in streaming mode.
  Future<String> _computeSha256(String filePath) async {
    final file = File(filePath);
    final hash = await sha256.bind(file.openRead()).first;
    return hash.toString();
  }

  bool _isVideo(String ext) {
    return [
      'mp4', 'mov', 'avi', 'mkv', 'webm',
    ].contains(ext);
  }
}
