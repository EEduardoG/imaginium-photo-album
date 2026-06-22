import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants.dart';
import '../../../providers.dart';
import '../../widgets/photo_card.dart';
import 'gallery_viewmodel.dart';

/// Main gallery screen — timeline grid of photos and videos grouped by year.
///
/// Features:
/// - Sticky year headers
/// - Filter chips (All, Photos, Videos)
/// - Batch selection mode (long press)
/// - Pull-to-refresh
/// - Responsive grid columns (desktop 4-5, mobile 3)
class GalleryScreen extends ConsumerStatefulWidget {
  const GalleryScreen({super.key});

  @override
  ConsumerState<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends ConsumerState<GalleryScreen> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(galleryViewModelProvider.notifier);
    final state = ref.watch(galleryViewModelProvider);
    final isDesktop = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: _buildAppBar(vm, state, context),
      body: _buildBody(state, vm, isDesktop),
      floatingActionButton: state.isSelectionMode
          ? null
          : FloatingActionButton(
              onPressed: () {
                // TODO: Open scan folder picker.
              },
              child: const Icon(Icons.add_photo_alternate),
            ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    GalleryViewModel vm,
    GalleryState state,
    BuildContext context,
  ) {
    if (state.isSelectionMode) {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: vm.clearSelection,
        ),
        title: Text('${state.selectedPhotos.length} selected'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: state.selectedPhotos.isNotEmpty
                ? () => _confirmDelete(vm)
                : null,
          ),
          IconButton(
            icon: const Icon(Icons.folder_outlined),
            onPressed: state.selectedPhotos.isNotEmpty ? () {} : null,
          ),
        ],
      );
    }

    return AppBar(
      title: const Text('Gallery'),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // TODO: Navigate to search screen.
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () {
            // TODO: Navigate to settings screen.
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: _FilterChips(
          current: state.filter,
          onChanged: vm.setFilter,
        ),
      ),
    );
  }

  Widget _buildBody(
    GalleryState state,
    GalleryViewModel vm,
    bool isDesktop,
  ) {
    if (state.isLoading && state.photosByYear.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.photosByYear.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 16),
            Text(state.error!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: vm.loadPhotos,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.photosByYear.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.photo_library_outlined,
                size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            const Text('No photos yet'),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Open scan folder picker.
              },
              icon: const Icon(Icons.folder_open),
              label: const Text('Scan folder'),
            ),
          ],
        ),
      );
    }

    final columns =
        isDesktop ? AppConstants.galleryColumnsDesktop : AppConstants.galleryColumnsMobile;
    final years = vm.sortedYears;

    return RefreshIndicator(
      onRefresh: vm.loadPhotos,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          for (final year in years) ...[
            SliverPersistentHeader(
              pinned: true,
              delegate: _YearHeaderDelegate(year: year),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                childAspectRatio: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final photo = vm.filteredPhotos[year]![index];
                  return PhotoCard(
                    photo: photo,
                    isSelected:
                        state.selectedPhotos.contains(photo.id),
                    isSelectionMode: state.isSelectionMode,
                    onTap: () {
                      if (state.isSelectionMode) {
                        vm.toggleSelection(photo.id);
                      } else {
                        // TODO: Open viewer with this photo.
                      }
                    },
                    onLongPress: () {
                      if (!state.isSelectionMode) {
                        vm.toggleSelection(photo.id);
                      }
                    },
                  );
                },
                childCount: vm.filteredPhotos[year]!.length,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _confirmDelete(GalleryViewModel vm) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete photos?'),
        content: const Text(
            'Photos will be moved to trash and can be restored within 30 days.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              vm.deleteSelected();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

/// Horizontal scrollable filter chips: All | Photos | Videos
class _FilterChips extends StatelessWidget {
  const _FilterChips({required this.current, required this.onChanged});

  final GalleryFilter current;
  final ValueChanged<GalleryFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: GalleryFilter.values.map((filter) {
          final isSelected = current == filter;
          final label = switch (filter) {
            GalleryFilter.all => 'All',
            GalleryFilter.photos => 'Photos',
            GalleryFilter.videos => 'Videos',
          };
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(label),
              selected: isSelected,
              onSelected: (_) => onChanged(filter),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// SliverPersistentHeaderDelegate for sticky year headers.
class _YearHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _YearHeaderDelegate({required this.year});

  final int year;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(
            year.toString(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant _YearHeaderDelegate oldDelegate) =>
      year != oldDelegate.year;
}
