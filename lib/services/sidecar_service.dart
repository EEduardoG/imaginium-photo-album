import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import '../data/models/sidecar_photo.dart';

/// Service for reading and writing `.photo.json` sidecar files.
///
/// Each media file (photo/video) has a companion `.photo.json` that contains
/// AI tags, category, and sync metadata. This enables:
/// - Cross-device sync via Proton Drive
/// - Database recovery from sidecar files
/// - Portable metadata
class SidecarService {
  /// Returns the expected sidecar path for a media file.
  ///
  /// Example: `/photos/IMG_001.jpg` → `/photos/IMG_001.photo.json`
  String sidecarPath(String mediaPath) {
    final ext = p.extension(mediaPath);
    final base = mediaPath.substring(0, mediaPath.length - ext.length);
    return '$base.photo.json';
  }

  /// Reads the sidecar JSON for a media file, or returns null if absent.
  Future<SidecarPhoto?> readSidecar(String mediaPath) async {
    final path = sidecarPath(mediaPath);
    final file = File(path);
    if (!await file.exists()) return null;

    try {
      final json = jsonDecode(await file.readAsString());
      return SidecarPhoto.fromJson(json as Map<String, dynamic>);
    } catch (_) {
      return null; // Corrupted sidecar — will be regenerated.
    }
  }

  /// Writes or updates the sidecar JSON for a media file.
  ///
  /// Merges with existing sidecar — never overwrites manual tags.
  Future<void> writeSidecar(
    String mediaPath,
    String sha256Hash, {
    String? category,
    List<(String, double, String)> tags = const [],
    String? description,
    bool ollamaProcessed = false,
  }) async {
    final path = sidecarPath(mediaPath);
    final existing = await readSidecar(mediaPath);

    // Preserve existing manual tags.
    final manualTags = existing?.tags
            .where((t) => t.source == 'manual')
            .map((t) => SidecarTag(
                  name: t.name,
                  confidence: t.confidence,
                  source: t.source,
                ))
            .toList() ??
        [];

    final newTags = <SidecarTag>[
      ...manualTags,
      ...tags.map((t) => SidecarTag(
            name: t.$1,
            confidence: t.$2,
            source: t.$3,
          )),
    ];

    // Deduplicate by name, keeping highest confidence.
    final uniqueTags = <String, SidecarTag>{};
    for (final tag in newTags) {
      final existing = uniqueTags[tag.name];
      if (existing == null || tag.confidence > existing.confidence) {
        uniqueTags[tag.name] = tag;
      }
    }

    final sidecar = SidecarPhoto(
      version: 1,
      photoHash: sha256Hash,
      category: category ?? existing?.category,
      tags: uniqueTags.values.toList(),
      description: description ?? existing?.description,
      aiProcessed: true,
      ollamaProcessed: ollamaProcessed || (existing?.ollamaProcessed ?? false),
      updatedAt: DateTime.now().toIso8601String(),
    );

    await File(path).writeAsString(
      const JsonEncoder.withIndent('  ').convert(sidecar.toJson()),
    );
  }

  /// Scans a directory recursively for `.photo.json` files and returns
  /// all parsed sidecars. Used for database recovery.
  Future<List<SidecarPhoto>> scanDirectory(String directoryPath) async {
    final sidecars = <SidecarPhoto>[];
    final dir = Directory(directoryPath);
    if (!await dir.exists()) return sidecars;

    await for (final entity in dir.list(recursive: true)) {
      if (entity is File && entity.path.endsWith('.photo.json')) {
        try {
          final json = jsonDecode(await entity.readAsString());
          final sidecar =
              SidecarPhoto.fromJson(json as Map<String, dynamic>);
          sidecars.add(sidecar);
        } catch (_) {
          // Skip corrupted files.
        }
      }
    }
    return sidecars;
  }

  /// Deletes the sidecar file for a media file (called on hard delete).
  Future<void> deleteSidecar(String mediaPath) async {
    final path = sidecarPath(mediaPath);
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
