/// Application-wide constants.
class AppConstants {
  AppConstants._();

  // -- Categories (MobileNetV3 output classes) --
  static const List<String> categories = [
    'people',
    'nature',
    'urban',
    'food',
    'animals',
    'documents',
    'screenshots',
    'art',
    'other',
  ];

  // -- TFLite --
  static const String ssdModelPath = 'assets/models/ssd_mobilenet_v2.tflite';
  static const int ssdInputSize = 300;

  // Confidence threshold for a detection to become a tag
  static const double yoloConfidenceThreshold = 0.4;

  // -- Video keyframe extraction --
  static const int keyframeIntervalSeconds = 2;
  static const int maxKeyframesPerVideo = 20;
  static const int longVideoThresholdSeconds = 1800; // 30 min
  static const int longVideoAnalysisSeconds = 300; // first 5 min

  // -- Thumbnails --
  static const int thumbnailSize = 256;
  static const int thumbnailQuality = 70;
  static const int maxThumbnailCacheMB = 500;

  // -- Gallery --
  static const int galleryColumnsDesktop = 4;
  static const int galleryColumnsMobile = 3;
  static const int galleryPageSize = 500;

  // Large year threshold: years with more photos than this start collapsed
  static const int largeYearThreshold = 5000;

  // -- Trash / Soft delete --
  static const int trashRetentionDays = 30;

  // -- Sync --
  static const int syncBatchSize = 10;
  static const int syncRetryMaxAttempts = 3;
  static const Duration syncRetryBackoff = Duration(seconds: 30);

  // -- Security --
  static const int biometricTimeoutMinutes = 2;
  static const int vaultPinMinLength = 4;
  static const int vaultPinMaxLength = 6;

  // -- Ollama --
  static const String ollamaBaseUrl = 'http://localhost:11434';
  static const String ollamaDefaultModel = 'llava:7b';

  // -- Proton Drive CLI --
  static const String protonCliBinary = 'proton';
  static const String protonRemoteFolder = '/imaginium';

  // -- Update checker --
  static const String githubApiReleases =
      'https://api.github.com/repos/lalo343x/imaginium-photo-album/releases/latest';

  // -- Supported image formats --
  static const Set<String> supportedImageFormats = {
    'jpg',
    'jpeg',
    'png',
    'webp',
    'bmp',
    'gif',
    'heic',
    'heif',
  };

  // -- Supported video formats --
  static const Set<String> supportedVideoFormats = {
    'mp4',
    'mov',
    'avi',
    'mkv',
    'webm',
  };

  // Hashing
  static const int hashStreamChunkSize = 8192; // 8 KB chunks
}
