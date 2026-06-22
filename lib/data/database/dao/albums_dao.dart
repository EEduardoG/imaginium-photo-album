import 'package:drift/drift.dart';
import '../database.dart';
import '../tables.dart';

part 'albums_dao.g.dart';

/// Data access object for [Albums] and [AlbumPhotos] tables.
@DriftAccessor(tables: [Albums, AlbumPhotos, Photos])
class AlbumsDao extends DatabaseAccessor<AppDatabase> with _$AlbumsDaoMixin {
  AlbumsDao(super.db);

  /// Returns all non-hidden albums ordered by creation date.
  Future<List<Album>> getVisibleAlbums() {
    return (select(albums)
          ..where((tbl) => tbl.isHidden.equals(false))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  /// Returns hidden albums (requires auth to view).
  Future<List<Album>> getHiddenAlbums() {
    return (select(albums)
          ..where((tbl) => tbl.isHidden.equals(true)))
        .get();
  }

  /// Returns all photos in an album, ordered by position.
  Future<List<Photo>> getPhotosInAlbum(String albumId) {
    final query = select(photos).join([
      innerJoin(albumPhotos, albumPhotos.photoId.equalsExp(photos.id)),
    ])
      ..where(albumPhotos.albumId.equals(albumId))
      ..where(photos.deletedAt.isNull())
      ..orderBy([OrderingTerm.asc(albumPhotos.position)]);
    return query.map((row) => row.readTable(photos)).get();
  }

  /// Creates a new album.
  Future<Album> createAlbum(AlbumsCompanion album) async {
    await into(albums).insert(album);
    final insertedId = album.id.present ? album.id.value : '';
    return (select(albums)
          ..where((tbl) => tbl.id.equals(insertedId)))
        .getSingle();
  }

  /// Adds a photo to an album at the specified position.
  Future<void> addPhotoToAlbum(
      String albumId, String photoId, int position) async {
    await into(albumPhotos).insertOnConflictUpdate(
      AlbumPhotosCompanion.insert(
        albumId: albumId,
        photoId: photoId,
        position: position,
      ),
    );
  }

  /// Removes a photo from an album.
  Future<void> removePhotoFromAlbum(String albumId, String photoId) async {
    await (delete(albumPhotos)
          ..where((tbl) =>
              tbl.albumId.equals(albumId) & tbl.photoId.equals(photoId)))
        .go();
  }

  /// Toggles the hidden status of an album.
  Future<void> toggleHidden(String albumId, bool hidden) async {
    await (update(albums)..where((tbl) => tbl.id.equals(albumId))).write(
      AlbumsCompanion(isHidden: Value(hidden)),
    );
  }

  /// Updates album cover photo.
  Future<void> updateCover(String albumId, String? photoId) async {
    await (update(albums)..where((tbl) => tbl.id.equals(albumId))).write(
      AlbumsCompanion(coverPhotoId: Value(photoId)),
    );
  }

  /// Deletes an album (photos remain, only the album is removed).
  Future<void> deleteAlbum(String albumId) async {
    await (delete(albums)..where((tbl) => tbl.id.equals(albumId))).go();
  }
}
