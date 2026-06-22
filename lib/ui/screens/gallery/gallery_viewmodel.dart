import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/database/database.dart';
import '../../../data/repositories/photo_repository.dart';

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
    this.error,
    this.selectedPhotos = const {},
    this.totalCount = 0,
  });

  final Map<int, List<Photo>> photosByYear;
  final GalleryFilter filter;
  final GalleryGrouping grouping;
  final bool isLoading;
  final bool isScanning;
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
      error: error,
      selectedPhotos: selectedPhotos ?? this.selectedPhotos,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}

/// Riverpod Notifier for gallery state management.
class GalleryViewModel extends StateNotifier<GalleryState> {
  GalleryViewModel({required this.repository})
      : super(const GalleryState()) {
    loadPhotos();
  }

  final PhotoRepository repository;

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
  List<int> get sortedYears => filteredPhotos.keys.toList()..sort((a, b) => b.compareTo(a));
}
