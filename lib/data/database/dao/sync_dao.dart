import 'package:drift/drift.dart';
import '../database.dart';

part 'sync_dao.g.dart';

/// Data access object for the [SyncStatusTable].
@DriftAccessor(tables: [SyncStatusTable, Photos])
class SyncDao extends DatabaseAccessor<AppDatabase> with _$SyncDaoMixin {
  SyncDao(super.db);

  /// Returns sync status for a single photo.
  Future<SyncStatusTableData?> getByPhotoId(String photoId) {
    return (select(syncStatusTable)
          ..where((tbl) => tbl.photoId.equals(photoId)))
        .getSingleOrNull();
  }

  /// Returns all photos with a given sync status.
  Future<List<SyncStatusTableData>> getByStatus(SyncStatus status) {
    return (select(syncStatusTable)
          ..where((tbl) => tbl.status.equals(status.name)))
        .get();
  }

  /// Returns all pending uploads (including sidecars).
  Future<List<SyncStatusTableData>> getPendingUploads() {
    return (select(syncStatusTable)
          ..where((tbl) =>
              tbl.status.equals(SyncStatus.pendingUpload.name) |
              tbl.sidecarSynced.equals(false)))
        .get();
  }

  /// Count of items pending sync.
  Future<int> pendingCount() async {
    final query = selectOnly(syncStatusTable)
      ..addColumns([syncStatusTable.photoId.count()])
      ..where(syncStatusTable.status.equals(SyncStatus.pendingUpload.name));
    final row = await query.getSingle();
    return row.read(syncStatusTable.photoId.count()) ?? 0;
  }

  /// Inserts or updates sync status for a photo.
  Future<void> upsert(SyncStatusTableCompanion status) async {
    await into(syncStatusTable).insertOnConflictUpdate(status);
  }

  /// Marks a photo as synced.
  Future<void> markSynced(String photoId, {String? protonFileId}) async {
    await into(syncStatusTable).insertOnConflictUpdate(
      SyncStatusTableCompanion.insert(
        photoId: photoId,
        status: SyncStatus.synced,
        protonFileId: Value(protonFileId),
        sidecarSynced: const Value(true),
        lastSyncedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Resets sync status to pending for re-sync.
  Future<void> resetToPending(String photoId) async {
    await (update(syncStatusTable)
          ..where((tbl) => tbl.photoId.equals(photoId)))
        .write(
      SyncStatusTableCompanion(
        status: const Value(SyncStatus.pendingUpload),
        sidecarSynced: const Value(false),
      ),
    );
  }
}
