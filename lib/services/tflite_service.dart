import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import '../core/constants.dart';

/// Result from YOLO-NAS object detection inference.
class YoloDetection {
  const YoloDetection({
    required this.label,
    required this.confidence,
  });

  final String label;
  final double confidence;
}

/// Result from MobileNetV3 classification inference.
class ClassificationResult {
  const ClassificationResult({
    required this.label,
    required this.confidence,
  });

  final String label;
  final double confidence;
}

/// Service that loads and runs TensorFlow Lite models for on-device AI.
///
/// Models are bundled as assets (see pubspec.yaml). The service loads them
/// lazily on first use and caches the interpreter in memory.
class TfliteService {
  Interpreter? _yoloInterpreter;
  Interpreter? _mobilenetInterpreter;
  bool _initialized = false;

  /// Whether models are loaded and ready for inference.
  bool get isInitialized => _initialized;

  /// Load both TFLite models into memory.
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      _yoloInterpreter = await Interpreter.fromAsset(
        AppConstants.yoloModelPath,
        options: InterpreterOptions()..threads = _optimalThreads,
      );

      _mobilenetInterpreter = await Interpreter.fromAsset(
        AppConstants.mobileNetModelPath,
        options: InterpreterOptions()..threads = _optimalThreads,
      );

      _initialized = true;
    } catch (e) {
      _initialized = false;
      rethrow;
    }
  }

  /// Runs YOLO-NAS object detection on [imageBytes] (raw file bytes).
  ///
  /// Returns a list of detected objects with labels and confidence scores.
  /// Only detections above [AppConstants.yoloConfidenceThreshold] are included.
  Future<List<YoloDetection>> detectObjects(Uint8List imageBytes) async {
    if (!_initialized) await initialize();

    final input = _prepareYoloInput(imageBytes);
    final output = _allocateYoloOutput();

    _yoloInterpreter!.run(input, output);

    return _parseYoloOutput(output);
  }

  /// Runs MobileNetV3 classification on [imageBytes].
  ///
  /// Returns the top predicted category label with confidence.
  Future<ClassificationResult> classifyImage(Uint8List imageBytes) async {
    if (!_initialized) await initialize();

    final input = _prepareMobileNetInput(imageBytes);
    final output = List.filled(1 * _numClasses, 0.0).reshape([1, _numClasses]);

    _mobilenetInterpreter!.run(input, output);

    return _parseClassificationOutput(output);
  }

  /// Release model memory. Call when AI is not needed (e.g., entering
  /// background, or user disabled AI in Settings).
  void dispose() {
    _yoloInterpreter?.close();
    _mobilenetInterpreter?.close();
    _yoloInterpreter = null;
    _mobilenetInterpreter = null;
    _initialized = false;
  }

  // -----------------------------------------------------------------------
  // Private helpers
  // -----------------------------------------------------------------------

  int get _optimalThreads {
    // Use half the available cores, minimum 2.
    final cores = Platform.numberOfProcessors;
    return cores > 2 ? cores ~/ 2 : 2;
  }

  static const int _numClasses = 9; // people, nature, urban, food, etc.

  List<Object> _prepareYoloInput(Uint8List bytes) {
    final decoded = img.decodeImage(bytes);
    if (decoded == null) {
      throw ArgumentError('Failed to decode image for YOLO input');
    }
    final resized = img.copyResize(
      decoded,
      width: AppConstants.yoloInputSize,
      height: AppConstants.yoloInputSize,
    );

    // Normalize to float32 [0, 1] — channel order expected by YOLO-NAS.
    final input = Float32List(1 * AppConstants.yoloInputSize *
        AppConstants.yoloInputSize * 3);
    int idx = 0;
    for (int y = 0; y < AppConstants.yoloInputSize; y++) {
      for (int x = 0; x < AppConstants.yoloInputSize; x++) {
        final pixel = resized.getPixel(x, y);
        input[idx++] = pixel.r / 255.0;
        input[idx++] = pixel.g / 255.0;
        input[idx++] = pixel.b / 255.0;
      }
    }
    return [input.reshape([1, AppConstants.yoloInputSize, AppConstants.yoloInputSize, 3])];
  }

  List<Object> _prepareMobileNetInput(Uint8List bytes) {
    final decoded = img.decodeImage(bytes);
    if (decoded == null) {
      throw ArgumentError('Failed to decode image for MobileNet input');
    }
    final resized = img.copyResize(
      decoded,
      width: AppConstants.mobileNetInputSize,
      height: AppConstants.mobileNetInputSize,
    );

    final input = Float32List(
        1 * AppConstants.mobileNetInputSize * AppConstants.mobileNetInputSize * 3);
    int idx = 0;
    for (int y = 0; y < AppConstants.mobileNetInputSize; y++) {
      for (int x = 0; x < AppConstants.mobileNetInputSize; x++) {
        final pixel = resized.getPixel(x, y);
        input[idx++] = (pixel.r / 255.0 - 0.5) * 2.0;
        input[idx++] = (pixel.g / 255.0 - 0.5) * 2.0;
        input[idx++] = (pixel.b / 255.0 - 0.5) * 2.0;
      }
    }
    return [input
        .reshape([1, AppConstants.mobileNetInputSize, AppConstants.mobileNetInputSize, 3])];
  }

  Map<int, Object> _allocateYoloOutput() {
    // YOLO-NAS outputs: [1, max_detections, label_index + confidence + bbox]
    // Simplified: allocate based on typical YOLO-NAS nano output shape.
    const maxDetections = 100;
    const outputSize = 6; // x, y, w, h, confidence, class
    return {
      0: Float32List(1 * maxDetections * outputSize)
          .reshape([1, maxDetections, outputSize]),
    };
  }

  List<YoloDetection> _parseYoloOutput(Map<int, Object> output) {
    // YOLO-NAS output: [1, max_detections, 6] (x, y, w, h, confidence, class)
    final raw = output[0] as List<List<List<double>>>;
    final batch = raw[0]; // first (and only) batch item
    final detections = <YoloDetection>[];
    for (final detection in batch) {
      if (detection.length < 6) continue;
      final confidence = detection[4];
      final classIndex = detection[5].toInt();

      if (confidence >= AppConstants.yoloConfidenceThreshold &&
          classIndex < _cocoLabels.length) {
        detections.add(
          YoloDetection(
            label: _cocoLabels[classIndex],
            confidence: confidence,
          ),
        );
      }
    }
    return detections;
  }

  ClassificationResult _parseClassificationOutput(List<dynamic> output) {
    final probabilities = output[0] as List<double>? ?? output[0] as List<double>;
    int maxIndex = 0;
    double maxProb = 0.0;
    for (int i = 0; i < probabilities.length; i++) {
      if (probabilities[i] > maxProb) {
        maxProb = probabilities[i];
        maxIndex = i;
      }
    }
    final label = maxIndex < AppConstants.categories.length
        ? AppConstants.categories[maxIndex]
        : 'other';
    return ClassificationResult(label: label, confidence: maxProb);
  }

  /// COCO dataset labels used by YOLO-NAS.
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
