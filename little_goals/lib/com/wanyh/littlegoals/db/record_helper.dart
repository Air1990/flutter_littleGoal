import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'goals_helper.dart';

final String tableRecords = 'records_table';
final String columnId = '_id';
final String columnGoalId = 'goalId';
final String columnDate = 'date';

class GoalRecord {
  int id;
  int goalId;
  int date;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnGoalId: goalId,
      columnDate: date,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  GoalRecord();

  GoalRecord.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    goalId = map[columnGoalId];
    date = map[columnDate];
  }
}

class RecordsProvider {
  static RecordsProvider _recordsProvider;
  Database _db;

  factory RecordsProvider() {
    if (_recordsProvider == null) {
      _recordsProvider = RecordsProvider._internal();
    }
    return _recordsProvider;
  }

  RecordsProvider._internal();

  Future<Database> open(String dbName) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableGoals ( 
  $columnId integer primary key autoincrement, 
  $columnName text not null,
  $columnDate integer not null,
  $columnImageUrl text not null,
  $columnSlogan text not null,
  $columnIsLocal integer not null)
''');
      await db.execute('''
create table $tableRecords (
  $columnId integer primary key autoincrement, 
  $columnGoalId integer not null,
  $columnDate integer not null)
''');
    });
    return _db;
  }

  Future close() async {
    _db?.close();
  }

  Future<GoalRecord> insert(GoalRecord record) async {
    record.id = await _db?.insert(tableRecords, record.toMap());
    return record;
  }

  Future<List<GoalRecord>> getRecords(int goalId) async {
    List<Map> maps = await _db
        ?.query(tableRecords, where: '$columnGoalId=?', whereArgs: [goalId]);
    List<GoalRecord> goalList = List();
    for (Map map in maps) {
      goalList.add(GoalRecord.fromMap(map));
    }
    return goalList;
  }

  Future<int> update(GoalRecord record) async {
    return await _db?.update(tableRecords, record.toMap(),
        where: '$columnId=?', whereArgs: [record.id]);
  }

  Future<int> deleteByGoalId(int goalId) async {
    return await _db
        ?.delete(tableRecords, where: '$columnGoalId=?', whereArgs: [goalId]);
  }
}
