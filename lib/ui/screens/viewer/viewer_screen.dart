import 'dart:io';
import 'package:flutter/material.dart';
import '../../../data/database/database.dart';
import '../../widgets/tag_chip.dart';

/// Full-screen photo/video viewer with swipe navigation, zoom, tags panel,
/// and EXIF info.
class ViewerScreen extends StatefulWidget {
  const ViewerScreen({
    super.key,
    required this.photos,
    required this.initialIndex,
  });

  final List<Photo> photos;
  final int initialIndex;

  @override
  State<ViewerScreen> createState() => _ViewerScreenState();
}

class _ViewerScreenState extends State<ViewerScreen> {
  late PageController _pageController;
  late int _currentIndex;
  bool _showOverlay = true;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final photo = widget.photos[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => setState(() => _showOverlay = !_showOverlay),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Photo / Video viewer
            PageView.builder(
              controller: _pageController,
              itemCount: widget.photos.length,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              itemBuilder: (context, index) {
                final p = widget.photos[index];
                if (p.mediaType == MediaType.video) {
                  // TODO: Use chewie/video_player for video playback.
                  return const Center(
                    child: Icon(Icons.play_circle_outline,
                        size: 64, color: Colors.white54),
                  );
                }
                return InteractiveViewer(
                  child: Image.file(
                    File(p.path),
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.broken_image,
                            size: 64, color: Colors.white38),
                      );
                    },
                  ),
                );
              },
            ),

            // Top bar (auto-hides after 3s)
            if (_showOverlay) _buildTopBar(context, photo),

            // Bottom tags panel
            if (_showOverlay) _buildBottomPanel(context, photo),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, Photo photo) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AppBar(
        backgroundColor: Colors.black54,
        leading: const BackButton(color: Colors.white),
        title: Text(
          photo.filename,
          style: const TextStyle(fontSize: 14),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border),
            onPressed: () {
              // TODO: Toggle favorite.
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // TODO: Show menu: move to album, vault, delete, share.
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPanel(BuildContext context, Photo photo) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.black87,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tags row
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TagChipList(
                tags: const ['playa', 'atardecer', 'vacaciones'],
                // TODO: Load from DB.
                showDelete: true,
                onTagDeleted: (_) {
                  // TODO: Remove tag.
                },
              ),
            ),
            // Add tag button
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 4),
              child: Row(
                children: [
                  Icon(Icons.add, size: 18, color: Colors.white70),
                  const SizedBox(width: 4),
                  Text(
                    'Add tag...',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
            // Metadata row
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Text(
                photo.takenAt != null
                    ? _formatDate(photo.takenAt!)
                    : 'Unknown date',
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_monthName(date.month)} ${date.year}  '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  String _monthName(int month) {
    const months = [
      '',
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return months[month];
  }
}
