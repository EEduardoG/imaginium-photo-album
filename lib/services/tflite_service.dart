import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import '../core/constants.dart';

class YoloDetection {
  const YoloDetection({required this.label, required this.confidence});
  final String label;
  final double confidence;
}

class ClassificationResult {
  const ClassificationResult({required this.label, required this.confidence});
  final String label;
  final double confidence;
}

class TfliteService {
  // Patrón Singleton para evitar múltiples instancias en el pipeline de fondo
  TfliteService._internal();
  static final TfliteService _instance = TfliteService._internal();
  factory TfliteService() => _instance;

  Interpreter? _interpreter;
  bool _loaded = false;

  bool get isLoaded => _loaded;

  Future<void> initialize() async {
    if (_loaded && _interpreter != null) return;
    try {
      final options = InterpreterOptions()..threads = _optimalThreads;
      _interpreter = await Interpreter.fromAsset(
        AppConstants.ssdModelPath,
        options: options,
      );

      // Verificamos el shape actual antes de redimensionar a ciegas
      final inputTensor = _interpreter!.getInputTensor(0);
      final currentShape = inputTensor.shape;
      
      // Solo aplicamos resize si el modelo no viene por defecto en [1, 300, 300, 3]
      if (currentShape.toString() != '[1, 300, 300, 3]') {
        _interpreter!.resizeInputTensor(0, [1, 300, 300, 3]);
      }
      
      _interpreter!.allocateTensors();
      _loaded = true;
      debugPrint('[TfliteService] SSD model successfully initialized.');
    } catch (e) {
      debugPrint('[TfliteService] SSD model failed to initialize: $e');
      _loaded = false;
    }
  }

  Future<List<YoloDetection>> detectObjects(Uint8List imageBytes) async {
    if (!_loaded) await initialize();
    if (!_loaded || _interpreter == null) return [];

    try {
      final input = _prepareInput(imageBytes);

      // Model outputs 20 detections max (from diagnostic).
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
      return _parseSsdFlat(classes, scores);
    } catch (e) {
      debugPrint('[TfliteService] Detection error: $e');
      return [];
    }
  }

  List<YoloDetection> _parseSsdFlat(Float32List classes, Float32List scores) {
    final detections = <YoloDetection>[];
    for (int i = 0; i < classes.length && i < scores.length; i++) {
      final score = scores[i];
      if (score >= AppConstants.yoloConfidenceThreshold) {
        final ci = classes[i].toInt();
        if (ci >= 0 && ci < _cocoLabels.length) {
          detections.add(YoloDetection(
            label: _cocoLabels[ci],
            confidence: score.toDouble(),
          ));
        }
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

  static const List<String> _cocoLabels = [
    'person', 'bicycle', 'car', 'motorcycle', 'airplane', 'bus', 'train',
    'truck', 'boat', 'traffic light', 'fire hydrant', 'stop sign',
    'parking meter', 'bench', 'bird', 'cat', 'dog', 'horse', 'sheep',
    'cow', 'elephant', 'bear', 'zebra', 'giraffe', 'backpack', 'umbrella',
    'handbag', 'tie', 'suitcase', 'frisbee', 'skis', 'snowboard',
    'sports ball', 'kite', 'baseball bat', 'baseball glove', 'skateboard',
    'surfboard', 'tennis racket', 'bottle', 'wine glass', 'cup', 'fork',
    'knife', 'spoon', 'bowl', 'banana', 'apple', 'sandwich', 'orange',
    'broccoli', 'carrot', 'hot dog', 'pizza', 'donut', 'cake', 'chair',
    'couch', 'potted plant', 'bed', 'dining table', 'toilet', 'tv',
    'laptop', 'mouse', 'remote', 'keyboard', 'cell phone', 'microwave',
    'oven', 'toaster', 'sink', 'refrigerator', 'book', 'clock', 'vase',
    'scissors', 'teddy bear', 'hair drier', 'toothbrush',
  ];
}