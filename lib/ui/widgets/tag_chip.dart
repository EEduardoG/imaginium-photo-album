import 'package:flutter/material.dart';
import '../../core/theme.dart';

/// A colored chip representing a tag assigned to a photo.
///
/// Tapping filters the gallery by this tag. Long-press removes the tag
/// from the current photo (in viewer mode).
class TagChip extends StatelessWidget {
  const TagChip({
    super.key,
    required this.label,
    this.color,
    this.onTap,
    this.onLongPress,
    this.onDeleted,
    this.showDelete = false,
  });

  /// The tag text displayed to the user.
  final String label;

  /// Optional override color. If null, a deterministic color is derived
  /// from the tag name.
  final Color? color;

  /// Called when the chip is tapped (filter gallery by this tag).
  final VoidCallback? onTap;

  /// Called on long press.
  final VoidCallback? onLongPress;

  /// Called when the delete icon is tapped.
  final VoidCallback? onDeleted;

  /// Whether to show a delete icon at the end of the chip.
  final bool showDelete;

  @override
  Widget build(BuildContext context) {
    final chipColor = color ?? AppTheme.colorForTag(label);

    return Semantics(
      label: 'Tag: $label. Tap to filter by $label',
      child: InputChip(
        label: Text(label),
        backgroundColor: chipColor.withOpacity(0.15),
        labelStyle: TextStyle(
          color: chipColor,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
        side: BorderSide(color: chipColor.withOpacity(0.4)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: onTap,
        onDeleted: showDelete ? onDeleted : null,
        deleteIcon: const Icon(Icons.close, size: 16),
      ),
    );
  }
}

/// Horizontal scrollable list of tag chips.
class TagChipList extends StatelessWidget {
  const TagChipList({
    super.key,
    required this.tags,
    this.onTagTap,
    this.showDelete = false,
    this.onTagDeleted,
  });

  final List<String> tags;
  final ValueChanged<String>? onTagTap;
  final bool showDelete;
  final ValueChanged<String>? onTagDeleted;

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: tags.length,
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        itemBuilder: (context, index) {
          return TagChip(
            label: tags[index],
            onTap: onTagTap != null ? () => onTagTap!(tags[index]) : null,
            showDelete: showDelete,
            onDeleted: onTagDeleted != null
                ? () => onTagDeleted!(tags[index])
                : null,
          );
        },
      ),
    );
  }
}
