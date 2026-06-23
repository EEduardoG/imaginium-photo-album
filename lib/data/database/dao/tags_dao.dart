import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'tags_dao.g.dart';

/// Data access object for [Tags] and [PhotoTags] tables.
@DriftAccessor(tables: [Tags, PhotoTags])
class TagsDao extends DatabaseAccessor<AppDatabase> with _$TagsDaoMixin {
  TagsDao(super.db);

  /// Find a tag by its name (case-insensitive match handled at app level).
  Future<Tag?> getByName(String name) {
    return (select(tags)..where((tbl) => tbl.name.equals(name)))
        .getSingleOrNull();
  }

  /// Returns all tags ordered alphabetically.
  Future<List<Tag>> getAll() {
    return (select(tags)..orderBy([(t) => OrderingTerm.asc(t.name)])).get();
  }

  /// Returns the most used tags (for autocomplete / suggestions).
  Future<List<Tag>> getMostUsed({int limit = 20}) async {
    final usageCount = photoTags.tagId.count();
    final query = selectOnly(tags, distinct: true)
      ..join([
        innerJoin(photoTags, photoTags.tagId.equalsExp(tags.id)),
      ])
      ..addColumns([tags.id, tags.name, tags.color])
      ..addColumns([usageCount])
      ..groupBy([tags.id])
      ..orderBy([OrderingTerm.desc(usageCount)])
      ..limit(limit);
    final rows = await query.get();
    return rows.map((row) {
      return Tag(
        id: row.read(tags.id)!,
        name: row.read(tags.name)!,
        color: row.read(tags.color),
        source: TagSource.aiDetector,
      );
    }).toList();
  }

  /// Search tags by prefix (for autocomplete).
  Future<List<Tag>> search(String query) {
    return (select(tags)
          ..where((tbl) => tbl.name.like('%$query%'))
          ..orderBy([(t) => OrderingTerm.asc(t.name)])
          ..limit(10))
        .get();
  }

  /// Insert a new tag.
  Future<void> insertTag(TagsCompanion tag) async {
    await into(tags).insertOnConflictUpdate(tag);
  }

  /// Remove a tag from a photo.
  Future<void> removeTagFromPhoto(String photoId, String tagId) async {
    await (delete(photoTags)
          ..where((tbl) =>
              tbl.photoId.equals(photoId) & tbl.tagId.equals(tagId)))
        .go();
  }

  /// Delete a tag completely (and all its photo associations via CASCADE).
  Future<void> deleteTag(String tagId) async {
    await (delete(tags)..where((tbl) => tbl.id.equals(tagId))).go();
  }
}
