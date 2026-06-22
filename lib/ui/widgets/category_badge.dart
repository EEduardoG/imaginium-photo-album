import 'package:flutter/material.dart';

/// Badge displaying the AI-assigned category of a photo.
///
/// Categories: people, nature, urban, food, animals, documents,
/// screenshots, art, other.
class CategoryBadge extends StatelessWidget {
  const CategoryBadge({
    super.key,
    required this.category,
  });

  final String category;

  IconData get _icon => switch (category) {
        'people' => Icons.people,
        'nature' => Icons.nature,
        'urban' => Icons.location_city,
        'food' => Icons.restaurant,
        'animals' => Icons.pets,
        'documents' => Icons.description,
        'screenshots' => Icons.screenshot,
        'art' => Icons.palette,
        _ => Icons.photo,
      };

  String get _label => switch (category) {
        'people' => 'People',
        'nature' => 'Nature',
        'urban' => 'Urban',
        'food' => 'Food',
        'animals' => 'Animals',
        'documents' => 'Documents',
        'screenshots' => 'Screenshots',
        'art' => 'Art',
        _ => 'Other',
      };

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Category: $_label',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_icon, size: 14),
            const SizedBox(width: 4),
            Text(
              _label,
              style: const TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
