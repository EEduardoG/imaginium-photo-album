import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'photos_dao.g.dart';

/// Data access object for the [Photos] table.
@DriftAccessor(tables: [Photos, PhotoTags, Tags, SyncStatusTable])
class PhotosDao extends DatabaseAccessor<AppDatabase>
    with _$PhotosDaoMixin {
  PhotosDao(super.db);

  // -----------------------------------------------------------------------
  // Queries
  // -----------------------------------------------------------------------

  /// Returns all non-deleted photos ordered by [Photos.takenAt] descending.
  Future<List<Photo>> getActivePhotos({int? limit, int? offset}) {
    final query = (select(photos)
      ..where((tbl) => tbl.deletedAt.isNull())
      ..orderBy([(t) => OrderingTerm.desc(t.takenAt)]));
    if (limit != null) query.limit(limit, offset: offset);
    return query.get();
  }

  /// Returns a single photo by [id].
  Future<Photo?> getById(String id) {
    return (select(photos)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  /// Returns a photo by its SHA-256 hash (for deduplication).
  Future<Photo?> getByHash(String sha256Hash) {
    return (select(photos)..where((tbl) => tbl.sha256Hash.equals(sha256Hash)))
        .getSingleOrNull();
  }

  /// Returns photos with a perceptual hash within Hamming distance.
  /// In production this uses a custom SQL function; here we return all
  /// active photos and let the service compare client-side.
  Future<List<Photo>> getNearPerceptualHash(String pHash) {
    return (select(photos)
      ..where((tbl) => tbl.deletedAt.isNull())
      ..where((tbl) => tbl.perceptualHash.isNotNull())).get();
  }

  /// Total count of active (non-deleted) photos.
  Future<int> activeCount() {
    return (selectOnly(photos)
          ..addColumns([photos.id.count()])
          ..where(photos.deletedAt.isNull()))
        .map((row) => row.read(photos.id.count()) ?? 0)
        .getSingle();
  }

  /// Photos grouped by year for the timeline gallery.
  Future<Map<int, List<Photo>>> getGroupedByYear() async {
    final all = await getActivePhotos();
    final grouped = <int, List<Photo>>{};
    for (final photo in all) {
      final year = photo.takenAt?.year ?? photo.createdAt.year;
      grouped.putIfAbsent(year, () => []).add(photo);
    }
    return grouped;
  }

  /// Photos in the trash (soft-deleted, not yet permanently deleted).
  Future<List<Photo>> getTrash() {
    return (select(photos)
      ..where((tbl) => tbl.deletedAt.isNotNull())
      ..orderBy([(t) => OrderingTerm.desc(t.deletedAt)])).get();
  }

  // -----------------------------------------------------------------------
  // Mutations
  // -----------------------------------------------------------------------

  /// Inserts a new photo record.
  Future<void> insertPhoto(PhotosCompanion photo) async {
    await into(photos).insertOnConflictUpdate(photo);
  }

  /// Soft-deletes a photo (moves to trash, sets deletedAt).
  Future<void> softDelete(String id) async {
    await (update(photos)..where((tbl) => tbl.id.equals(id))).write(
      PhotosCompanion(
        deletedAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Restores a photo from trash.
  Future<void> restore(String id) async {
    await (update(photos)..where((tbl) => tbl.id.equals(id))).write(
      PhotosCompanion(
        deletedAt: const Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Permanently deletes a photo record.
  Future<void> hardDelete(String id) async {
    await (delete(photos)..where((tbl) => tbl.id.equals(id))).go();
  }

  /// Permanently deletes all photos where deletedAt is older than [cutoff].
  Future<int> purgeOldTrash(DateTime cutoff) {
    return (delete(photos)
          ..where((tbl) => tbl.deletedAt.isSmallerThanValue(cutoff)))
        .go();
  }

  // -----------------------------------------------------------------------
  // Tags
  // -----------------------------------------------------------------------

  /// Returns all tags for a given photo.
  Future<List<Tag>> getTagsForPhoto(String photoId) {
    final query = select(tags).join([
      innerJoin(photoTags, photoTags.tagId.equalsExp(tags.id)),
    ])
      ..where(photoTags.photoId.equals(photoId));
    return query.map((row) => row.readTable(tags)).get();
  }

  /// Adds a tag to a photo (or updates confidence if it already exists).
  Future<void> addTagToPhoto(
    String photoId,
    String tagId,
    TagSource source, {
    double? confidence,
  }) async {
    await into(photoTags).insertOnConflictUpdate(
      PhotoTagsCompanion.insert(
        photoId: photoId,
        tagId: tagId,
        source: source,
        confidence: Value(confidence),
      ),
    );
  }
}
