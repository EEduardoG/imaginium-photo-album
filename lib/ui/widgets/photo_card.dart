import 'dart:io';
import 'package:flutter/material.dart';
import '../../data/database/database.dart';

/// A single thumbnail card in the gallery grid.
///
/// Displays a photo or video with indicators for sync status, media type,
/// and batch selection overlay.
class PhotoCard extends StatelessWidget {
  const PhotoCard({
    super.key,
    required this.photo,
    this.isSelected = false,
    this.isSelectionMode = false,
    this.onTap,
    this.onLongPress,
  });

  final Photo photo;
  final bool isSelected;
  final bool isSelectionMode;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final isVideo = photo.mediaType == MediaType.video;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Semantics(
        label: isVideo
            ? 'Video. ${photo.filename}'
            : 'Photo. ${photo.filename}',
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Thumbnail image
              _ThumbnailImage(path: photo.path),

              // Selection overlay
              if (isSelectionMode)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(
                    isSelected
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white70,
                  ),
                ),

              // Video indicator
              if (isVideo)
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.play_arrow, size: 14, color: Colors.white),
                        if (photo.durationMs != null) ...[
                          const SizedBox(width: 2),
                          Text(
                            _formatDuration(photo.durationMs!),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

              // Sync status indicator
              Positioned(
                top: 8,
                left: 8,
                child: _SyncBadge(photoId: photo.id),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(int ms) {
    final seconds = ms ~/ 1000;
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}

/// Simple thumbnail loader using [Image.file].
class _ThumbnailImage extends StatelessWidget {
  const _ThumbnailImage({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Image.file(
      // ignore: flutter_style_todos
      // TODO: Use cached thumbnail from thumbnail_service for performance.
      File(path),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Center(
          child: Icon(Icons.broken_image, color: Colors.white38),
        );
      },
    );
  }
}

/// Placeholder sync status badge.
class _SyncBadge extends StatelessWidget {
  const _SyncBadge({required this.photoId});

  final String photoId;

  @override
  Widget build(BuildContext context) {
    // TODO: Wire up to actual sync state via provider.
    return const SizedBox.shrink();
  }
}

