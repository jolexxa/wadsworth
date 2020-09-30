import 'package:sqflite/sqflite.dart';
import 'package:lifelog_repo/src/models/models.dart';

class LifelogClient {
  static final String table = 'lifelog';

  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $table ( 
  ${Lifelog.columnId} integer primary key autoincrement, 
  ${Lifelog.columnMood} integer not null,
  ${Lifelog.columnThoughts} string not null)
''');
    });
  }

  Future<Lifelog> insert(Lifelog lifelog) async {
    lifelog.id = await db.insert(table, lifelog.toMap());
    return lifelog;
  }

  Future<Lifelog> getLifelog(int id) async {
    List<Map> maps = await db.query(table,
        columns: [Lifelog.columnId, Lifelog.columnMood, Lifelog.columnThoughts],
        where: '${Lifelog.columnId} = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Lifelog.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db
        .delete(table, where: '${Lifelog.columnId} = ?', whereArgs: [id]);
  }

  Future<int> update(Lifelog lifelog) async {
    return await db.update(table, lifelog.toMap(),
        where: '${Lifelog.columnId} = ?', whereArgs: [lifelog.id]);
  }

  Future close() async => db.close();
}
