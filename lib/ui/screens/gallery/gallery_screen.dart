import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import '../../../core/constants.dart';
import '../../../providers.dart';
import '../../../services/photo_scanner_service.dart';
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
  void initState() {
    super.initState();
    // Start directory watching on the next frame so the widget is mounted.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(galleryViewModelProvider.notifier).startWatching();
      }
    });
  }

  @override
  void dispose() {
    ref.read(galleryViewModelProvider.notifier).stopWatching();
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
      // Show import status banner when auto-importing.
      persistentFooterButtons: state.isImporting || state.importStatusMessage != null
          ? [
              _ImportStatusBanner(
                isImporting: state.isImporting,
                filename: state.importingFilename,
                message: state.importStatusMessage,
              ),
            ]
          : null,
      floatingActionButton: state.isSelectionMode
          ? null
          : FloatingActionButton(
              onPressed: () => _scanFolder(context),
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
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Gallery'),
          if (state.isWatching) ...[
            const SizedBox(width: 8),
            Tooltip(
              message: _buildWatchingTooltip(vm),
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ],
      ),
      actions: [
        if (state.isWatching)
          Tooltip(
            message: _buildWatchingTooltip(vm),
            child: const Padding(
              padding: EdgeInsets.only(right: 4),
              child: Icon(Icons.visibility, size: 20, color: Colors.green),
            ),
          ),
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
              onPressed: () => _scanFolder(context),
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

  Future<void> _scanFolder(BuildContext context) async {
    final result = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Select a folder to scan for photos and videos',
    );
    if (result == null || !context.mounted) return;

    final vm = ref.read(galleryViewModelProvider.notifier);
    final scannerService = ref.read(photoScannerServiceProvider);

    // Show scanning snackbar BEFORE updating state to avoid
    // triggering overlays during a rebuild (mouse_tracker assertion).
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(width: 12),
            Text('Scanning folder...'),
          ],
        ),
        duration: Duration(hours: 1), // Keep visible during scan.
      ),
    );
    vm.setScanning(true);

    int imported = 0;
    try {
      await for (final scanResult
          in scannerService.scanDirectory(result)) {
        await scannerService.persistScanResult(scanResult);
        imported++;
      }
    } catch (e) {
      if (context.mounted) {
        _showSnackBarAfterFrame(
          context,
          SnackBar(content: Text('Scan error: $e')),
        );
      }
    } finally {
      vm.setScanning(false);
      await vm.loadPhotos();
      _showSnackBarAfterFrame(
        context,
        SnackBar(
          duration: const Duration(seconds: 3),
          content: Text(
            imported > 0
                ? 'Imported $imported new photos'
                : 'No new photos found',
          ),
        ),
      );
    }

    // AI categorization is now handled by BackgroundCategorizationService.
    // The photos will be tagged automatically in the background.
  }

  /// Builds a tooltip describing which directories are being watched.
  String _buildWatchingTooltip(GalleryViewModel vm) {
    final dirs = vm.watchedDirectories;
    if (dirs.isEmpty) return 'Not watching any directories';
    final names = dirs.map((d) {
      final parts = d.split('/');
      return parts.isNotEmpty ? parts.last : d;
    }).join(', ');
    return 'Watching: $names';
  }

  /// Shows a snackbar on the next frame to avoid triggering Flutter's
  /// `!_debugDuringDeviceUpdate` assertion when called during a rebuild.
  void _showSnackBarAfterFrame(BuildContext context, SnackBar snackBar) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    });
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

/// Banner shown at the bottom of the gallery when an auto-import is in
/// progress or has just completed.
class _ImportStatusBanner extends StatelessWidget {
  const _ImportStatusBanner({
    required this.isImporting,
    this.filename,
    this.message,
  });

  final bool isImporting;
  final String? filename;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: isImporting
          ? Colors.blue.shade50
          : (message?.contains('failed') == true
              ? Colors.red.shade50
              : Colors.green.shade50),
      child: Row(
        children: [
          if (isImporting)
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else
            Icon(
              message?.contains('failed') == true
                  ? Icons.error_outline
                  : message?.contains('duplicate') == true
                      ? Icons.info_outline
                      : Icons.check_circle,
              size: 18,
              color: message?.contains('failed') == true
                  ? Colors.red
                  : Colors.green,
            ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message ?? (isImporting ? 'Importing $filename...' : ''),
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
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
    return SizedBox(
      height: maxExtent,
      child: Container(
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
