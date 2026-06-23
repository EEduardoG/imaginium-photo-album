import 'package:drift/drift.dart';

/// Enum for media type: photo or video.
enum MediaType { photo, video }

/// Enum for tag source: which AI or manual.
enum TagSource { aiDetector, aiClassifier, aiOllama, manual }

/// Enum for sync status of a photo in relation to Proton Drive.
enum SyncStatus { localOnly, pendingUpload, synced, pendingDownload, conflict }

// ---------------------------------------------------------------------------
// Table definitions
// ---------------------------------------------------------------------------

/// Photos and videos share the same table, differentiated by [mediaType].
class Photos extends Table {
  TextColumn get id => text()();
  TextColumn get path => text()();
  TextColumn get filename => text()();
  TextColumn get mediaType => textEnum<MediaType>()();
  TextColumn get sha256Hash => text()();
  TextColumn get perceptualHash => text().nullable()();
  IntColumn get sizeBytes => integer()();
  IntColumn get width => integer().nullable()();
  IntColumn get height => integer().nullable()();

  /// File extension without dot (jpg, png, mp4, mov...).
  TextColumn get format => text()();

  /// Duration in milliseconds (videos only).
  IntColumn get durationMs => integer().nullable()();

  /// Video codec (h264, h265, vp9), null for photos.
  TextColumn get codec => text().nullable()();

  /// Frames per second (videos only).
  RealColumn get fps => real().nullable()();

  /// EXIF / recording date.
  DateTimeColumn get takenAt => dateTime().nullable()();

  /// Soft-delete timestamp. NULL = active.
  DateTimeColumn get deletedAt => dateTime().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
        'UNIQUE(sha256_hash)',
      ];
}

/// Tags assigned to media (both AI-generated and manual).
class Tags extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get color => text().nullable()();
  TextColumn get source => textEnum<TagSource>()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Many-to-many relationship between photos and tags.
class PhotoTags extends Table {
  TextColumn get photoId => text().references(Photos, #id, onDelete: KeyAction.cascade)();
  TextColumn get tagId => text().references(Tags, #id, onDelete: KeyAction.cascade)();
  RealColumn get confidence => real().nullable()();
  TextColumn get source => textEnum<TagSource>()();

  @override
  Set<Column> get primaryKey => {photoId, tagId};
}

/// Predefined categories (people, nature, urban, food, etc.).
class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().unique()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Many-to-many relationship between photos and categories.
class PhotoCategories extends Table {
  TextColumn get photoId => text().references(Photos, #id, onDelete: KeyAction.cascade)();
  TextColumn get categoryId => text().references(Categories, #id, onDelete: KeyAction.cascade)();
  RealColumn get confidence => real().nullable()();

  @override
  Set<Column> get primaryKey => {photoId, categoryId};
}

/// User-created albums.
class Albums extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();

  /// Whether this album is hidden (requires auth to view).
  BoolColumn get isHidden => boolean().withDefault(const Constant(false))();
  TextColumn get coverPhotoId => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Many-to-many relationship between albums and photos.
class AlbumPhotos extends Table {
  TextColumn get albumId => text().references(Albums, #id, onDelete: KeyAction.cascade)();
  TextColumn get photoId => text().references(Photos, #id, onDelete: KeyAction.cascade)();
  IntColumn get position => integer()();

  @override
  Set<Column> get primaryKey => {albumId, photoId};
}

/// Sync status of each photo with Proton Drive.
class SyncStatusTable extends Table {
  TextColumn get photoId => text().references(Photos, #id, onDelete: KeyAction.cascade)();
  TextColumn get status => textEnum<SyncStatus>()();
  TextColumn get protonFileId => text().nullable()();

  /// Whether the sidecar .photo.json has been synced to Proton.
  BoolColumn get sidecarSynced =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {photoId};
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/// Simple UUID v4 generator used as client default for primary keys.
String _uuid() {
  // In production this uses the `uuid` package.
  // Stub implementation for drift table definitions.
  return DateTime.now().microsecondsSinceEpoch.toRadixString(36) +
      (DateTime.now().millisecondsSinceEpoch % 10000).toRadixString(16);
}
