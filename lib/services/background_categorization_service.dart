import 'dart:async';
import 'package:flutter/foundation.dart';
import '../data/database/database.dart';
import '../data/database/dao/photos_dao.dart';
import '../data/repositories/photo_repository.dart';

/// Background service that processes photos through AI categorization
/// one at a time, without blocking the UI or the import pipeline.
///
/// How it works:
/// 1. On [start], it queries the database for active photos that have no
///    tags (uncategorized).
/// 2. Processes them sequentially — SSD MobileNet for tags, writes sidecar.
/// 3. After finishing the initial batch, it keeps polling every 30 seconds
///    for newly imported uncategorized photos.
/// 4. Runs completely silently — no UI feedback needed.
class BackgroundCategorizationService {
  BackgroundCategorizationService({
    required this.repository,
    required this.photosDao,
  });

  final PhotoRepository repository;
  final PhotosDao photosDao;

  bool _isRunning = false;
  bool _isProcessing = false;
  Timer? _pollTimer;

  /// Photo IDs that have already failed categorization — don't retry.
  final Set<String> _failedPhotoIds = {};

  /// Photo IDs that have been successfully processed — don't retry.
  final Set<String> _processedPhotoIds = {};

  bool get isRunning => _isRunning;
  bool get isProcessing => _isProcessing;

  // -----------------------------------------------------------------------
  // Lifecycle
  // -----------------------------------------------------------------------

  /// Start the background processing loop.
  ///
  /// Immediately processes any existing uncategorized photos, then polls
  /// every 30 seconds for new ones.
  void start() {
    if (_isRunning) return;
    _isRunning = true;
    debugPrint('[BackgroundCategorization] Started');
    _processLoop();
  }

  /// Stop the background processing loop.
  void stop() {
    _isRunning = false;
    _pollTimer?.cancel();
    _pollTimer = null;
    _failedPhotoIds.clear();
    _processedPhotoIds.clear();
    debugPrint('[BackgroundCategorization] Stopped');
  }

  /// Wake up the service to process any pending photos immediately.
  void wakeUp() {
    if (!_isRunning) return;
    if (_isProcessing) return;
    _processLoop();
  }

  /// Clear processed/failed sets so photos get re-categorized on next cycle.
  void resetProcessed() {
    _processedPhotoIds.clear();
    _failedPhotoIds.clear();
    debugPrint('[BackgroundCategorization] Reset — all photos will be re-categorized');
  }

  // -----------------------------------------------------------------------
  // Private
  // -----------------------------------------------------------------------

  Future<void> _processLoop() async {
    if (!_isRunning || _isProcessing) return;

    _isProcessing = true;

    try {
      // Find photos that need categorization (no tags yet).
      final uncategorized = await _findUncategorizedPhotos();
      if (uncategorized.isNotEmpty) {
        debugPrint(
            '[BackgroundCategorization] Found ${uncategorized.length} uncategorized photos');
      }

      for (final photo in uncategorized) {
        if (!_isRunning) break;

        if (_processedPhotoIds.contains(photo.id)) continue;
        if (_failedPhotoIds.contains(photo.id)) continue;

        try {
          debugPrint(
              '[BackgroundCategorization] Categorizing: ${photo.filename}');
          await repository.categorizeAndPersist(photo);
          _processedPhotoIds.add(photo.id);
          debugPrint(
              '[BackgroundCategorization] Done: ${photo.filename}');
        } catch (e) {
          debugPrint(
              '[BackgroundCategorization] Failed ${photo.filename}: $e');
          _failedPhotoIds.add(photo.id);
        }
      }
    } catch (e) {
      debugPrint('[BackgroundCategorization] Loop error: $e');
    } finally {
      _isProcessing = false;

      // Schedule next poll if still running.
      if (_isRunning) {
        _pollTimer?.cancel();
        _pollTimer = Timer(const Duration(seconds: 30), () {
          _processLoop();
        });
      }
    }
  }

  /// Returns active photos that have zero tags assigned.
  Future<List<Photo>> _findUncategorizedPhotos() async {
    // Get all active photos.
    final allPhotos = await photosDao.getActivePhotos();

    // Filter to those without tags.
    final uncategorized = <Photo>[];
    for (final photo in allPhotos) {
      // Only process photos (skip videos for now).
      if (photo.mediaType != MediaType.photo) continue;

      final tags = await photosDao.getTagsForPhoto(photo.id);
      if (tags.isEmpty) {
        uncategorized.add(photo);
      }
    }

    return uncategorized;
  }
}
