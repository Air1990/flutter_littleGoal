import 'package:little_goals/com/wanyh/littlegoals/db/record_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableGoals = 'goals_table';
final String columnId = '_id';
final String columnName = 'name';
final String columnDate = 'date';
final String columnImageUrl = 'imageUrl';
final String columnSlogan = 'slogan';
final String columnIsLocal = 'isLocal';

class LittleGoal {
  int id;
  String name;
  int date;
  String imageUrl;
  String slogan;
  bool isLocal = true;

  bool isSigned = false;
  int seriesSign;
  int totalSign;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnDate: date,
      columnImageUrl: imageUrl,
      columnSlogan: slogan,
      columnIsLocal: isLocal ? 1 : 0,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  LittleGoal();

  LittleGoal.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    date = map[columnDate];
    imageUrl = map[columnImageUrl];
    slogan = map[columnSlogan];
    isLocal = map[columnIsLocal] == 1;
  }
}

class GoalsProvider {
  static GoalsProvider _goalsProvider;
  Database _db;

  factory GoalsProvider() {
    if (_goalsProvider == null) {
      _goalsProvider = GoalsProvider._internal();
    }
    return _goalsProvider;
  }

  GoalsProvider._internal();

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

  Future<LittleGoal> insert(LittleGoal goal) async {
    goal.id = await _db?.insert(tableGoals, goal.toMap());
    return goal;
  }

  Future<List<LittleGoal>> getAllGoals() async {
    List<Map> maps =
        await _db?.query(tableGoals, orderBy: '$columnId ASC');
    List<LittleGoal> goalList = List();
    for (Map map in maps) {
      goalList.add(LittleGoal.fromMap(map));
    }
    return goalList;
  }

  Future<int> update(LittleGoal goal) async {
    return await _db?.update(tableGoals, goal.toMap(),
        where: '$columnId=?', whereArgs: [goal.id]);
  }

  Future<int> delete(LittleGoal goal) async {
    return await _db
        ?.delete(tableGoals, where: '$columnId=', whereArgs: [goal.id]);
  }
}
