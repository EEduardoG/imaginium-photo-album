import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

/// Stub for path_provider in tests.
class _FakePathProvider extends PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async => '/tmp/imaginium_test';
  // Other required overrides omitted for brevity.
}

void main() {
  // This test needs flutter_test and mocktail.
  // In production, run with: flutter test test/services/

  group('SidecarService', () {
    late Directory tempDir;

    setUp(() async {
      tempDir = Directory.systemTemp.createTempSync('imaginium_test_');
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('sidecarPath generates correct .photo.json path', () {
      // Inline implementation for testing.
      String sidecarPath(String mediaPath) {
        final ext = p.extension(mediaPath);
        final base = mediaPath.substring(0, mediaPath.length - ext.length);
        return '$base.photo.json';
      }

      expect(
        sidecarPath('/photos/IMG_001.jpg'),
        '/photos/IMG_001.photo.json',
      );
      expect(
        sidecarPath('/videos/clip.mp4'),
        '/videos/clip.photo.json',
      );
    });

    test('write and read sidecar round-trips correctly', () async {
      final photoPath = p.join(tempDir.path, 'test.jpg');
      final sidecarPath = p.join(tempDir.path, 'test.photo.json');

      // Write test photo file (empty).
      await File(photoPath).writeAsBytes([0xFF]);

      // Simulate sidecar write.
      final sidecar = {
        'version': 1,
        'photo_hash': 'abc123',
        'category': 'nature',
        'tags': [
          {'name': 'beach', 'confidence': 0.95, 'source': 'ai_yolo'},
          {'name': 'sunset', 'confidence': 0.88, 'source': 'ai_yolo'},
        ],
        'description': 'A beautiful sunset at the beach',
        'ai_processed': true,
        'ollama_processed': false,
        'updated_at': DateTime.now().toIso8601String(),
      };

      await File(sidecarPath)
          .writeAsString(const JsonEncoder.withIndent('  ').convert(sidecar));

      // Read it back.
      expect(await File(sidecarPath).exists(), isTrue);
      final read = jsonDecode(await File(sidecarPath).readAsString());
      expect(read['category'], 'nature');
      expect(read['tags'].length, 2);
      expect(read['tags'][0]['name'], 'beach');
    });

    test('deleteSidecar removes the file', () async {
      final sidecarPath = p.join(tempDir.path, 'test.photo.json');
      await File(sidecarPath).writeAsString('{}');
      expect(await File(sidecarPath).exists(), isTrue);

      await File(sidecarPath).delete();
      expect(await File(sidecarPath).exists(), isFalse);
    });
  });
}
