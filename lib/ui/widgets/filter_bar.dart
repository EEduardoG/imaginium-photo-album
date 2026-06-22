import 'package:flutter/material.dart';

/// Scrollable horizontal bar of filter chips for common tags and categories.
///
/// Used in the gallery screen for quick filtering by popular tags.
class FilterBar extends StatelessWidget {
  const FilterBar({
    super.key,
    required this.tags,
    this.selectedTags = const {},
    this.onTagToggled,
  });

  /// All available filter tags.
  final List<String> tags;

  /// Currently selected tags.
  final Set<String> selectedTags;

  /// Called when a tag is toggled.
  final ValueChanged<String>? onTagToggled;

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: tags.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final tag = tags[index];
          final isSelected = selectedTags.contains(tag);
          return FilterChip(
            label: Text(tag),
            selected: isSelected,
            onSelected: (_) => onTagToggled?.call(tag),
            showCheckmark: false,
          );
        },
      ),
    );
  }
}
