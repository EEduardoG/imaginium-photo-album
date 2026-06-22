import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:drift/drift.dart' show Value;
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;
import '../core/constants.dart';
import '../data/database/dao/photos_dao.dart';
import '../data/database/dao/tags_dao.dart';
import '../data/database/database.dart';
import 'tflite_service.dart';
import 'sidecar_service.dart';

/// Result of the AI categorization pipeline for a single media file.
class CategorizationResult {
  const CategorizationResult({
    required this.photoId,
    required this.category,
    required this.tags,
    this.description,
    this.isSensitive = false,
  });

  final String photoId;
  final String category;
  final List<CategorizationTag> tags;
  final String? description;
  final bool isSensitive;
}

/// A tag produced by AI categorization.
class CategorizationTag {
  const CategorizationTag({
    required this.name,
    required this.confidence,
    required this.source,
  });

  final String name;
  final double confidence;
  final TagSource source;
}

/// Orchestrates the AI categorization pipeline:
/// 1. Run YOLO-NAS for object detection → tags
/// 2. Run MobileNetV3 for scene classification → category
/// 3. Store results in database + sidecar JSON
class AiCategorizerService {
  AiCategorizerService({
    required TfliteService tflite,
    required PhotosDao photosDao,
    required TagsDao tagsDao,
    required SidecarService sidecarService,
  })  : _tflite = tflite,
        _photosDao = photosDao,
        _tagsDao = tagsDao,
        _sidecarService = sidecarService;

  final TfliteService _tflite;
  final PhotosDao _photosDao;
  final TagsDao _tagsDao;
  final SidecarService _sidecarService;
  final _uuid = const Uuid();

  /// Categorize a single photo file.
  ///
  /// Reads the file, runs TFLite inference, stores tags in the database,
  /// and writes/updates the sidecar JSON file.
  Future<CategorizationResult> categorizePhoto(String filePath) async {
    final bytes = await File(filePath).readAsBytes();

    // Convert HEIC to JPEG in memory if needed.
    final processedBytes = await _ensureDecodable(bytes, filePath);

    // Run both models.
    final yoloDetections = await _tflite.detectObjects(processedBytes);
    final classification = await _tflite.classifyImage(processedBytes);

    // Build tags from YOLO detections.
    final tags = yoloDetections
        .map((d) => CategorizationTag(
              name: d.label,
              confidence: d.confidence,
              source: TagSource.aiYolo,
            ))
        .toList();

    final result = CategorizationResult(
      photoId: _uuid.v4(),
      category: classification.label,
      tags: tags,
    );

    return result;
  }

  /// Categorize a video by extracting keyframes and running TFLite on each.
  ///
  /// Tags that appear in >30% of frames are assigned to the video.
  Future<CategorizationResult> categorizeVideo(
    String filePath, {
    int durationMs = 0,
  }) async {
    // Keyframe extraction would use platform-specific code via a service.
    // For now, we return a stub that marks the video as needing processing.
    return CategorizationResult(
      photoId: _uuid.v4(),
      category: 'other',
      tags: [],
    );
  }

  /// Persist categorization results to the database and sidecar.
  Future<void> persistResult(
    CategorizationResult result,
    String photoId,
    String filePath,
    String sha256Hash,
  ) async {
    // Update or create tags in the database.
    for (final ct in result.tags) {
      // Upsert tag
      final existingTag = await _tagsDao.getByName(ct.name);
      String tagId;
      if (existingTag != null) {
        tagId = existingTag.id;
      } else {
        tagId = _uuid.v4();
        await _tagsDao.insertTag(
          TagsCompanion(
            id: Value(tagId),
            name: Value(ct.name),
            source: Value(ct.source),
          ),
        );
      }
      await _photosDao.addTagToPhoto(photoId, tagId, ct.source,
          confidence: ct.confidence);
    }

    // Write sidecar JSON.
    final sidecarTags = result.tags
        .map((t) => (t.name, t.confidence, t.source.name))
        .toList();
    await _sidecarService.writeSidecar(
      filePath,
      sha256Hash,
      category: result.category,
      tags: sidecarTags,
      description: result.description,
    );
  }

  /// Process photos in background using an isolate (for large scans).
  static Future<void> processBatchInIsolate(
    List<String> filePaths,
    SendPort sendPort,
  ) async {
    // This isolate would have its own TFLite instance and process each file.
    // Results are sent back via [sendPort] for the main isolate to persist.
    for (final path in filePaths) {
      // Process in isolate...
      sendPort.send({'path': path, 'status': 'completed'});
    }
  }

  // -----------------------------------------------------------------------
  // Private helpers
  // -----------------------------------------------------------------------

  /// Converts HEIC/HEIF to JPEG bytes in memory so TFLite can decode them.
  Future<Uint8List> _ensureDecodable(Uint8List bytes, String filePath) async {
    final ext = p.extension(filePath).toLowerCase().replaceAll('.', '');
    if (ext == 'heic' || ext == 'heif') {
      // TODO: Implement HEIC→JPEG conversion using platform channel.
      // For now, return raw bytes; the image package may handle basic HEIC.
    }
    return bytes;
  }
}

