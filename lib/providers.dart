import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/database/database.dart';
import 'data/database/dao/photos_dao.dart';
import 'data/database/dao/tags_dao.dart';
import 'data/database/dao/albums_dao.dart';
import 'data/database/dao/sync_dao.dart';
import 'data/repositories/photo_repository.dart';
import 'services/tflite_service.dart';
import 'services/sidecar_service.dart';
import 'ui/screens/gallery/gallery_viewmodel.dart';

// ---------------------------------------------------------------------------
// Database
// ---------------------------------------------------------------------------

/// Singleton database instance.
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

// ---------------------------------------------------------------------------
// DAOs
// ---------------------------------------------------------------------------

final photosDaoProvider = Provider<PhotosDao>((ref) {
  return PhotosDao(ref.watch(databaseProvider));
});

final tagsDaoProvider = Provider<TagsDao>((ref) {
  return TagsDao(ref.watch(databaseProvider));
});

final albumsDaoProvider = Provider<AlbumsDao>((ref) {
  return AlbumsDao(ref.watch(databaseProvider));
});

final syncDaoProvider = Provider<SyncDao>((ref) {
  return SyncDao(ref.watch(databaseProvider));
});

// ---------------------------------------------------------------------------
// Services
// ---------------------------------------------------------------------------

final tfliteServiceProvider = Provider<TfliteService>((ref) {
  return TfliteService();
});

final sidecarServiceProvider = Provider<SidecarService>((ref) {
  return SidecarService();
});

// ---------------------------------------------------------------------------
// Repositories
// ---------------------------------------------------------------------------

final photoRepositoryProvider = Provider<PhotoRepository>((ref) {
  return PhotoRepository(
    photosDao: ref.watch(photosDaoProvider),
    tagsDao: ref.watch(tagsDaoProvider),
    tfliteService: ref.watch(tfliteServiceProvider),
    sidecarService: ref.watch(sidecarServiceProvider),
  );
});

// ---------------------------------------------------------------------------
// ViewModels
// ---------------------------------------------------------------------------

final galleryViewModelProvider =
    StateNotifierProvider<GalleryViewModel, GalleryState>((ref) {
  return GalleryViewModel(repository: ref.watch(photoRepositoryProvider));
});
