import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:lifelog_repo/src/entities/entities.dart';

class LifelogClient {
  static final String databaseName = 'wadsworth.db';
  static final int databaseVersion = 1;
  static final String table = 'lifelog';

  static Database db;

  LifelogClient._privateConstructor();

  static LifelogClient _instance;

  static Future<LifelogClient> get instance async {
    if (_instance != null) return _instance;
    _instance = LifelogClient._privateConstructor();
    await _instance._open();
    return _instance;
  }

  _open() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    db = await openDatabase(
      path,
      version: databaseVersion,
      onCreate: (Database db, int version) async {
        await db.execute('''
create table $table ( 
  ${LifelogEntity.columnId} integer primary key autoincrement, 
  ${LifelogEntity.columnMood} integer not null,
  ${LifelogEntity.columnThoughts} string not null,
  ${LifelogEntity.columnTimestamp} string not null)
''');
      },
    );
  }

  Future<LifelogEntity> insert(LifelogEntity lifelog) async {
    lifelog.id = await db.insert(table, lifelog.toMap());
    return lifelog;
  }

  Future<List<LifelogEntity>> all() async {
    final List<Map> result = await db.query(
      table,
      columns: [
        LifelogEntity.columnId,
        LifelogEntity.columnMood,
        LifelogEntity.columnThoughts,
        LifelogEntity.columnTimestamp,
      ],
      orderBy: '${LifelogEntity.columnTimestamp} DESC',
    );
    final lifelogEntities =
        result.map((map) => LifelogEntity.fromMap(map)).toList();
    return lifelogEntities;
  }

  Future<LifelogEntity> getLifelog(int id) async {
    List<Map> maps = await db.query(
      table,
      columns: [
        LifelogEntity.columnId,
        LifelogEntity.columnMood,
        LifelogEntity.columnThoughts,
        LifelogEntity.columnTimestamp,
      ],
      where: '${LifelogEntity.columnId} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return LifelogEntity.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db
        .delete(table, where: '${LifelogEntity.columnId} = ?', whereArgs: [id]);
  }

  Future<int> update(LifelogEntity lifelog) async {
    return await db.update(table, lifelog.toMap(),
        where: '${LifelogEntity.columnId} = ?', whereArgs: [lifelog.id]);
  }

  Future close() async => db.close();
}
