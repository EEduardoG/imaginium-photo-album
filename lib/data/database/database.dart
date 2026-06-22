import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import 'tables.dart';
export 'tables.dart';

part 'database.g.dart';

/// The drift database for Imaginium Photo Album.
///
/// Uses a native SQLite backend. Switch to sqlcipher_flutter_libs for
/// encrypted storage when the user enables SQLCipher in Settings.
@DriftDatabase(
  tables: [
    Photos,
    Tags,
    PhotoTags,
    Categories,
    PhotoCategories,
    Albums,
    AlbumPhotos,
    SyncStatusTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          // Seed the predefined categories.
          await _seedCategories();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Future migrations go here.
        },
      );

  Future<void> _seedCategories() async {
    const categoryNames = [
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
    const uuid = Uuid();
    for (final name in categoryNames) {
      await into(categories).insert(
        CategoriesCompanion.insert(id: uuid.v4(), name: name),
      );
    }
  }

  /// Vacuum the database to reclaim space after many deletions.
  Future<void> vacuum() async {
    await customStatement('VACUUM');
  }

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'imaginium.db'));
      return NativeDatabase(file);
    });
  }
}
