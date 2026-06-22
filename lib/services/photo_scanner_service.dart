import 'dart:io';
import 'dart:isolate';
import 'package:drift/drift.dart' show Value;
import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;
import '../core/constants.dart';
import '../data/database/database.dart';
import '../data/database/dao/photos_dao.dart';

/// Result of scanning a single media file.
class ScanResult {
  const ScanResult({
    required this.path,
    required this.filename,
    required this.mediaType,
    required this.sha256Hash,
    required this.sizeBytes,
    this.width,
    this.height,
    this.format,
    this.durationMs,
    this.takenAt,
  });

  final String path;
  final String filename;
  final MediaType mediaType;
  final String sha256Hash;
  final int sizeBytes;
  final int? width;
  final int? height;
  final String? format;
  final int? durationMs;
  final DateTime? takenAt;
}

/// Service that scans directories for photos and videos.
///
/// Computes SHA-256 hashes for deduplication and extracts basic metadata.
/// Heavy scanning runs in an isolate to avoid blocking the UI.
class PhotoScannerService {
  PhotoScannerService({required this.photosDao});

  final PhotosDao photosDao;
  final _uuid = const Uuid();

  /// Scan a single directory (non-recursive by default).
  Stream<ScanResult> scanDirectory(
    String directoryPath, {
    bool recursive = true,
  }) async* {
    final dir = Directory(directoryPath);
    if (!await dir.exists()) return;

    final entities = recursive ? dir.listSync(recursive: true) : dir.listSync();

    for (final entity in entities) {
      if (entity is! File) continue;

      final ext = p.extension(entity.path).toLowerCase().replaceAll('.', '');
      final isImage = AppConstants.supportedImageFormats.contains(ext);
      final isVideo = AppConstants.supportedVideoFormats.contains(ext);
      if (!isImage && !isVideo) continue;

      final file = entity;
      final fileStat = await file.stat();

      // Compute SHA-256 hash for deduplication.
      final hash = await _computeSha256(file.path);

      // Check if already in database.
      final existing = await photosDao.getByHash(hash);
      if (existing != null) continue; // Duplicate, skip.

      yield ScanResult(
        path: file.path,
        filename: p.basename(file.path),
        mediaType: isVideo ? MediaType.video : MediaType.photo,
        sha256Hash: hash,
        sizeBytes: fileStat.size,
        format: ext,
        takenAt: fileStat.modified,
      );
    }
  }

  /// Persist a scan result to the database.
  Future<void> persistScanResult(ScanResult result) async {
    final photoId = _uuid.v4();
    await photosDao.insertPhoto(
      PhotosCompanion.insert(
        id: photoId,
        path: result.path,
        filename: result.filename,
        mediaType: result.mediaType,
        sha256Hash: result.sha256Hash,
        sizeBytes: result.sizeBytes,
        width: const Value.absent(),
        height: const Value.absent(),
        format: result.format ?? 'jpg',
        durationMs: Value(result.durationMs),
        codec: const Value.absent(),
        fps: const Value.absent(),
        takenAt: Value(result.takenAt ?? DateTime.now()),
        deletedAt: const Value.absent(),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Compute SHA-256 hash of a file in streaming mode.
  Future<String> _computeSha256(String filePath) async {
    final file = File(filePath);
    final hash = await sha256.bind(file.openRead()).first;
    return hash.toString();
  }
}
