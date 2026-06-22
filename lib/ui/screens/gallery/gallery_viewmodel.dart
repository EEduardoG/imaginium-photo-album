import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/database/database.dart';
import '../../../data/repositories/photo_repository.dart';
import '../../../services/directory_watcher_service.dart';
import '../../../services/photo_import_pipeline.dart';

/// Filter mode for the gallery grid.
enum GalleryFilter { all, photos, videos }

/// Grouping mode for the timeline.
enum GalleryGrouping { year, month, none }

/// State for the gallery screen.
class GalleryState {
  const GalleryState({
    this.photosByYear = const {},
    this.filter = GalleryFilter.all,
    this.grouping = GalleryGrouping.year,
    this.isLoading = false,
    this.isScanning = false,
    this.isWatching = false,
    this.isImporting = false,
    this.importingFilename,
    this.importStatusMessage,
    this.error,
    this.selectedPhotos = const {},
    this.totalCount = 0,
  });

  final Map<int, List<Photo>> photosByYear;
  final GalleryFilter filter;
  final GalleryGrouping grouping;
  final bool isLoading;
  final bool isScanning;
  final bool isWatching;
  final bool isImporting;
  final String? importingFilename;
  final String? importStatusMessage;
  final String? error;
  final Set<String> selectedPhotos;
  final int totalCount;

  bool get isSelectionMode => selectedPhotos.isNotEmpty;

  GalleryState copyWith({
    Map<int, List<Photo>>? photosByYear,
    GalleryFilter? filter,
    GalleryGrouping? grouping,
    bool? isLoading,
    bool? isScanning,
    bool? isWatching,
    bool? isImporting,
    String? importingFilename,
    String? importStatusMessage,
    String? error,
    Set<String>? selectedPhotos,
    int? totalCount,
  }) {
    return GalleryState(
      photosByYear: photosByYear ?? this.photosByYear,
      filter: filter ?? this.filter,
      grouping: grouping ?? this.grouping,
      isLoading: isLoading ?? this.isLoading,
      isScanning: isScanning ?? this.isScanning,
      isWatching: isWatching ?? this.isWatching,
      isImporting: isImporting ?? this.isImporting,
      importingFilename: importingFilename,
      importStatusMessage: importStatusMessage,
      error: error,
      selectedPhotos: selectedPhotos ?? this.selectedPhotos,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}

/// Riverpod Notifier for gallery state management.
class GalleryViewModel extends StateNotifier<GalleryState> {
  GalleryViewModel({
    required this.repository,
    required this.directoryWatcher,
    required this.importPipeline,
  }) : super(const GalleryState()) {
    loadPhotos();
  }

  final PhotoRepository repository;
  final DirectoryWatcherService directoryWatcher;
  final PhotoImportPipeline importPipeline;

  StreamSubscription<WatchedFileEvent>? _watcherSubscription;
  StreamSubscription<PhotoImportResult>? _importSubscription;

  /// Load all active photos grouped by year.
  Future<void> loadPhotos() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final grouped = await repository.getPhotosByYear();
      final total = await repository.activeCount();
      state = state.copyWith(
        photosByYear: grouped,
        totalCount: total,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Apply a media type filter.
  void setFilter(GalleryFilter filter) {
    state = state.copyWith(filter: filter);
  }

  /// Change grouping mode.
  void setGrouping(GalleryGrouping grouping) {
    state = state.copyWith(grouping: grouping);
  }

  /// Toggle batch selection for a photo.
  void toggleSelection(String photoId) {
    final selected = Set<String>.from(state.selectedPhotos);
    if (selected.contains(photoId)) {
      selected.remove(photoId);
    } else {
      selected.add(photoId);
    }
    state = state.copyWith(selectedPhotos: selected);
  }

  /// Clear all selections.
  void clearSelection() {
    state = state.copyWith(selectedPhotos: const {});
  }

  /// Set the scanning state (used by the gallery screen).
  void setScanning(bool value) {
    state = state.copyWith(isScanning: value);
  }

  /// Delete selected photos (soft delete).
  Future<void> deleteSelected() async {
    for (final id in state.selectedPhotos) {
      await repository.softDelete(id);
    }
    clearSelection();
    await loadPhotos();
  }

  /// Get the filtered and grouped photos.
  Map<int, List<Photo>> get filteredPhotos {
    final all = state.photosByYear;
    if (state.filter == GalleryFilter.all) return all;

    final filtered = <int, List<Photo>>{};
    for (final entry in all.entries) {
      final matching = entry.value.where((p) {
        if (state.filter == GalleryFilter.photos) {
          return p.mediaType == MediaType.photo;
        }
        return p.mediaType == MediaType.video;
      }).toList();
      if (matching.isNotEmpty) {
        filtered[entry.key] = matching;
      }
    }
    return filtered;
  }

  /// Years sorted descending (most recent first).
  List<int> get sortedYears =>
      filteredPhotos.keys.toList()..sort((a, b) => b.compareTo(a));

  // -----------------------------------------------------------------------
  // Directory watching
  // -----------------------------------------------------------------------

  /// Start monitoring default directories (~/Downloads, ~/Pictures) for new
  /// media files. When a new file is detected, it flows through the import
  /// pipeline and the gallery auto-refreshes.
  Future<void> startWatching() async {
    if (state.isWatching) return;

    debugPrint('[GalleryViewModel] Starting watcher...');
    // Start the directory watcher.
    await directoryWatcher.start();

    // Listen for new files from the watcher and feed them to the pipeline.
    _watcherSubscription = directoryWatcher.fileStream.listen((event) {
      debugPrint(
          '[GalleryViewModel] Watcher event received: ${event.path} (${event.eventType})');
      final filename = event.path.split('/').last;
      state = state.copyWith(
        isImporting: true,
        importingFilename: filename,
        importStatusMessage: 'Importing $filename...',
      );
      importPipeline.importFile(event.path);
    });

    // Listen for import results and refresh the gallery.
    _importSubscription = importPipeline.importStream.listen((result) {
      debugPrint(
          '[GalleryViewModel] Import result: success=${result.success} '
          'file=${result.filePath} '
          'duplicate=${result.skippedDuplicate} '
          'error=${result.error}');
      if (result.success) {
        final filename = result.filePath.split('/').last;
        state = state.copyWith(
          isImporting: false,
          importingFilename: null,
          importStatusMessage: 'Imported: $filename',
        );
        loadPhotos();
        // Clear the status message after a few seconds.
        Future.delayed(const Duration(seconds: 4), () {
          if (state.importStatusMessage == 'Imported: $filename') {
            state = state.copyWith(importStatusMessage: null);
          }
        });
      } else if (result.skippedDuplicate) {
        state = state.copyWith(
          isImporting: false,
          importingFilename: null,
          importStatusMessage: 'Already in library (duplicate)',
        );
        Future.delayed(const Duration(seconds: 3), () {
          state = state.copyWith(importStatusMessage: null);
        });
      } else {
        state = state.copyWith(
          isImporting: false,
          importingFilename: null,
          importStatusMessage: 'Import failed: ${result.error ?? "unknown"}',
        );
        Future.delayed(const Duration(seconds: 5), () {
          state = state.copyWith(importStatusMessage: null);
        });
      }
    });

    state = state.copyWith(isWatching: true);
    debugPrint('[GalleryViewModel] Watching started, state.isWatching=${state.isWatching}');
  }

  /// Stop monitoring directories. The watcher and subscriptions are cleaned up.
  Future<void> stopWatching() async {
    if (!state.isWatching) return;

    await directoryWatcher.stop();
    _watcherSubscription?.cancel();
    _watcherSubscription = null;
    _importSubscription?.cancel();
    _importSubscription = null;

    state = state.copyWith(isWatching: false);
  }

  /// Add a directory to the watch list. Takes effect immediately.
  Future<void> addWatchedDirectory(String path) async {
    await directoryWatcher.addDirectory(path);
  }

  /// Remove a directory from the watch list.
  Future<void> removeWatchedDirectory(String path) async {
    await directoryWatcher.removeDirectory(path);
  }

  /// The list of currently watched directories.
  List<String> get watchedDirectories => directoryWatcher.watchedDirectories;

  @override
  void dispose() {
    stopWatching();
    directoryWatcher.dispose();
    importPipeline.dispose();
    super.dispose();
  }
}
