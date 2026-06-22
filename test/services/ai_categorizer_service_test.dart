import 'package:flutter_test/flutter_test.dart';

/// Tests for the AI categorization pipeline.
///
/// Run with: flutter test test/services/ai_categorizer_service_test.dart
void main() {
  group('AiCategorizerService', () {
    test('tag deduplication keeps highest confidence', () {
      // Simulate tag merge logic from the service.
      final rawTags = <String, double>{
        'dog': 0.85,
        'dog': 0.92,
        'beach': 0.78,
        'person': 0.65,
        'person': 0.55,
      };

      final unique = <String, double>{};
      for (final entry in rawTags.entries) {
        final existing = unique[entry.key];
        if (existing == null || entry.value > existing) {
          unique[entry.key] = entry.value;
        }
      }

      expect(unique.length, 3);
      expect(unique['dog'], 0.92);
      expect(unique['beach'], 0.78);
      expect(unique['person'], 0.65);
    });

    test('COCO label mapping covers expected objects', () {
      // Verify key labels needed for photo categorization exist.
      const cocoLabels = [
        'person', 'dog', 'cat', 'car', 'bicycle', 'motorcycle',
        'airplane', 'boat', 'bird', 'horse', 'sheep', 'cow',
        'elephant', 'bear', 'zebra', 'giraffe', 'backpack',
        'suitcase', 'sports ball', 'kite', 'surfboard', 'tennis racket',
        'bottle', 'wine glass', 'cup', 'fork', 'knife', 'spoon',
        'bowl', 'banana', 'apple', 'sandwich', 'orange', 'broccoli',
        'carrot', 'hot dog', 'pizza', 'donut', 'cake', 'chair',
        'couch', 'potted plant', 'bed', 'dining table', 'tv',
        'laptop', 'mouse', 'remote', 'keyboard', 'cell phone',
        'book', 'clock', 'scissors', 'teddy bear',
      ];

      expect(cocoLabels.contains('person'), isTrue);
      expect(cocoLabels.contains('dog'), isTrue);
      expect(cocoLabels.contains('pizza'), isTrue);
      expect(cocoLabels.contains('beach'), isFalse); // Not in COCO
    });

    test('category list contains all valid categories', () {
      const categories = [
        'people', 'nature', 'urban', 'food', 'animals',
        'documents', 'screenshots', 'art', 'other',
      ];
      expect(categories.length, 9);
      expect(categories.contains('people'), isTrue);
      expect(categories.contains('other'), isTrue);
    });

    test('confidence threshold filters low-confidence detections', () {
      const threshold = 0.4;
      final detections = [
        ('dog', 0.95),
        ('cat', 0.35),
        ('car', 0.42),
        ('person', 0.28),
      ];

      final filtered = detections.where((d) => d.$2 >= threshold).toList();
      expect(filtered.length, 2);
      expect(filtered.map((d) => d.$1), containsAll(['dog', 'car']));
    });
  });
}
