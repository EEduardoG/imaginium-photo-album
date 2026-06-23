import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import '../core/constants.dart';

class ObjectDetection {
  const ObjectDetection({required this.label, required this.confidence});
  final String label;
  final double confidence;
}

class ClassificationResult {
  const ClassificationResult({required this.label, required this.confidence});
  final String label;
  final double confidence;
}

class TfliteService {
  Interpreter? _interpreter;
  bool _loaded = false;

  bool get isLoaded => _loaded;

  Future<void> initialize() async {
    if (_loaded) return;
    try {
      _interpreter = await Interpreter.fromAsset(
        AppConstants.ssdModelPath,
        options: InterpreterOptions()..threads = _optimalThreads,
      );
      _loaded = true;
      debugPrint('[TfliteService] SSD model loaded');
    } catch (e) {
      debugPrint('[TfliteService] SSD model failed: $e');
    }
  }

  Future<List<ObjectDetection>> detectObjects(Uint8List imageBytes) async {
    if (!_loaded) await initialize();
    if (!_loaded || _interpreter == null) return [];

    try {
      final input = _prepareInput(imageBytes);

      const maxDet = 20;
      final classes = Float32List(maxDet);
      final scores = Float32List(maxDet);
      final locations = Float32List(maxDet * 4);
      final numDetections = Float32List(1);

      final output = {
        0: locations.buffer,
        1: classes.buffer,
        2: scores.buffer,
        3: numDetections.buffer,
      };

      _interpreter!.runForMultipleInputs([input.buffer], output);
      final detections = _parseDetections(classes, scores);
      if (detections.isNotEmpty) {
        final tags = detections.map((d) => d.label).join(', ');
        debugPrint('[TfliteService] Detected: $tags');
      }
      return detections;
    } catch (e) {
      debugPrint('[TfliteService] Detection error: $e');
      return [];
    }
  }

  List<ObjectDetection> _parseDetections(
      Float32List classes, Float32List scores) {
    final detections = <ObjectDetection>[];
    for (int i = 0; i < classes.length && i < scores.length; i++) {
      final score = scores[i];
      if (score < AppConstants.detectionConfidenceThreshold) continue;
      final ci = classes[i].toInt();
      if (ci > 0 && ci < _cocoLabels.length) {
        detections.add(ObjectDetection(
          label: _cocoLabels[ci],
          confidence: score.toDouble(),
        ));
      }
    }
    return detections;
  }

  Future<ClassificationResult> classifyImage(Uint8List imageBytes) async {
    return const ClassificationResult(label: 'other', confidence: 0.0);
  }

  void dispose() {
    _interpreter?.close();
    _interpreter = null;
    _loaded = false;
  }

  int get _optimalThreads {
    final cores = Platform.numberOfProcessors;
    return cores > 2 ? cores ~/ 2 : 2;
  }

  Uint8List _prepareInput(Uint8List bytes) {
    final decoded = img.decodeImage(bytes);
    if (decoded == null) throw ArgumentError('Failed to decode image');
    final resized = img.copyResize(decoded, width: 300, height: 300);
    final input = Uint8List(1 * 300 * 300 * 3);
    int idx = 0;
    for (int y = 0; y < 300; y++) {
      for (int x = 0; x < 300; x++) {
        final p = resized.getPixel(x, y);
        input[idx++] = p.r.toInt();
        input[idx++] = p.g.toInt();
        input[idx++] = p.b.toInt();
      }
    }
    return input;
  }

  /// COCO 2017 labels, 1-indexed (0=background, 1-90=objects).
  static const List<String> _cocoLabels = [
    'background',
    'person', 'bicycle', 'car', 'motorcycle', 'airplane', 'bus',
    'train', 'truck', 'boat', 'traffic light', 'fire hydrant',
    'stop sign', 'parking meter', 'bench', 'bird', 'cat', 'dog',
    'horse', 'sheep', 'cow', 'elephant', 'bear', 'zebra', 'giraffe',
    'backpack', 'umbrella', 'handbag', 'tie', 'suitcase', 'frisbee',
    'skis', 'snowboard', 'sports ball', 'kite', 'baseball bat',
    'baseball glove', 'skateboard', 'surfboard', 'tennis racket',
    'bottle', 'wine glass', 'cup', 'fork', 'knife', 'spoon', 'bowl',
    'banana', 'apple', 'sandwich', 'orange', 'broccoli', 'carrot',
    'hot dog', 'pizza', 'donut', 'cake', 'chair', 'couch',
    'potted plant', 'bed', 'dining table', 'toilet', 'tv', 'laptop',
    'mouse', 'remote', 'keyboard', 'cell phone', 'microwave', 'oven',
    'toaster', 'sink', 'refrigerator', 'book', 'clock', 'vase',
    'scissors', 'teddy bear', 'hair drier', 'toothbrush',
    'hair brush',
  ];
}
