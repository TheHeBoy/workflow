import 'dart:io';

import 'package:drift/native.dart';
import 'package:get/get.dart' hide Value;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
part 'sqlite_database.g.dart';

@DataClassName("AppShortcut")
class AppShortcuts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get path => text()();
  TextColumn get iconPath => text()();
  TextColumn get shortcutName => text()();
  IntColumn get order => integer().nullable()();
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(
  tables: [AppShortcuts],
)
class AppDataBase extends _$AppDataBase {
  AppDataBase() : super(_openConnection());

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;

  //READ
  Future<List<AppShortcut>> getAllAppShortcuts() => select(appShortcuts).get();
  //Stream<List<AppShortcut>> watchAllAppShortcuts() => select(appShortcuts).watch();
  Stream<List<AppShortcut>> watchAllAppShortcuts() => (select(appShortcuts)..orderBy([(t) => OrderingTerm(expression: t.order)])).watch();
  //INSERT
  Future insertAppShortcut(AppShortcutsCompanion appShortcut) => into(appShortcuts).insertReturning(appShortcut);
  //Update
  Future updateAppShortcut(AppShortcut appShortcut) => update(appShortcuts).replace(appShortcut);
  //Delete
  Future deleteAppShortcut(AppShortcutsCompanion appShortcut) => delete(appShortcuts).delete(appShortcut);
}
