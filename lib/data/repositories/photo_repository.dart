import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../../core/constants.dart';
import '../database/database.dart';
import '../database/dao/photos_dao.dart';
import '../database/dao/tags_dao.dart';
import '../../services/ai_categorizer_service.dart';
import '../../services/sidecar_service.dart';
import '../../services/tflite_service.dart';

/// Repository that coordinates photo CRUD, AI categorization, and sidecar
/// management. Acts as the single source of truth for photo operations.
class PhotoRepository {
  PhotoRepository({
    required this.photosDao,
    required this.tagsDao,
    required this.tfliteService,
    required this.sidecarService,
  });

  final PhotosDao photosDao;
  final TagsDao tagsDao;
  final TfliteService tfliteService;
  final SidecarService sidecarService;

  // -----------------------------------------------------------------------
  // Gallery queries
  // -----------------------------------------------------------------------

  /// Active photos with pagination support.
  Future<List<Photo>> getPhotos({int? limit, int? offset}) {
    return photosDao.getActivePhotos(limit: limit, offset: offset);
  }

  /// Photos grouped by year for the timeline gallery.
  Future<Map<int, List<Photo>>> getPhotosByYear() {
    return photosDao.getGroupedByYear();
  }

  /// Count of active (non-deleted) photos.
  Future<int> activeCount() => photosDao.activeCount();

  /// Single photo by id.
  Future<Photo?> getPhoto(String id) => photosDao.getById(id);

  // -----------------------------------------------------------------------
  // AI categorization
  // -----------------------------------------------------------------------

  /// Categorize a single photo and persist the results.
  Future<void> categorizeAndPersist(Photo photo) async {
    final categorizer = AiCategorizerService(
      tflite: tfliteService,
      photosDao: photosDao,
      tagsDao: tagsDao,
      sidecarService: sidecarService,
    );

    final result = await categorizer.categorizePhoto(photo.path);
    await categorizer.persistResult(
      result,
      photo.id,
      photo.path,
      photo.sha256Hash,
    );
  }

  /// Categorize a batch of photos sequentially (to avoid overloading the CPU).
  Future<int> categorizeBatch(List<Photo> photos) async {
    int categorized = 0;
    final categorizer = AiCategorizerService(
      tflite: tfliteService,
      photosDao: photosDao,
      tagsDao: tagsDao,
      sidecarService: sidecarService,
    );

    for (final photo in photos) {
      try {
        final result = await categorizer.categorizePhoto(photo.path);
        await categorizer.persistResult(
          result,
          photo.id,
          photo.path,
          photo.sha256Hash,
        );
        categorized++;
      } catch (_) {
        // Skip failed photos; the error service will log it.
      }
    }
    return categorized;
  }

  // -----------------------------------------------------------------------
  // Tags
  // -----------------------------------------------------------------------

  /// Get all tags for a photo.
  Future<List<Tag>> getTags(String photoId) {
    return photosDao.getTagsForPhoto(photoId);
  }

  /// Search tags for autocomplete.
  Future<List<Tag>> searchTags(String query) {
    return tagsDao.search(query);
  }

  // -----------------------------------------------------------------------
  // Deduplication
  // -----------------------------------------------------------------------

  /// Check if a file with the given SHA-256 hash already exists.
  Future<Photo?> findDuplicateByHash(String sha256Hash) {
    return photosDao.getByHash(sha256Hash);
  }

  // -----------------------------------------------------------------------
  // Delete
  // -----------------------------------------------------------------------

  /// Move a photo to trash (soft delete).
  Future<void> softDelete(String photoId) {
    return photosDao.softDelete(photoId);
  }

  /// Restore a photo from trash.
  Future<void> restore(String photoId) {
    return photosDao.restore(photoId);
  }

  /// Permanently delete a photo and its sidecar.
  Future<void> hardDelete(Photo photo) async {
    await photosDao.hardDelete(photo.id);
    await sidecarService.deleteSidecar(photo.path);
  }

  /// Purge trash items older than the retention period.
  Future<int> purgeOldTrash() async {
    final cutoff = DateTime.now()
        .subtract(Duration(days: AppConstants.trashRetentionDays));
    return photosDao.purgeOldTrash(cutoff);
  }
}
