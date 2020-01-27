import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

class DataBases extends Table {
  IntColumn get id => integer()();
  TextColumn get userName => text().withLength(min: 1, max: 25)();
  TextColumn get age => text().withLength(min: 1, max: 3)();
  BoolColumn get validate => boolean().withDefault(Constant(false))();
}

@UseMoor(tables: [DataBases])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          logStatements: true,
        ));
  @override
  int get schemaVersion => 1;

  Future<DataBase> getAllData() => select(dataBases).getSingle();
  Future insertTask(DataBase data) => into(dataBases).insert(data);
  Future updateTask(DataBase data) => update(dataBases).replace(data);
  Future deleteTask(DataBase data) => delete(dataBases).delete(data);
  Future resetDb() async {
    for (var table in allTables) {
      await delete(table).go();
    }
  }
}
