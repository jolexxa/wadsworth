import 'package:meta/meta.dart';

class LifelogEntity {
  static final String columnId = '_id';
  static final String columnMood = 'mood';
  static final String columnThoughts = 'thoughts';
  static final String columnTimestamp = 'timestamp';

  int id;
  int mood;
  String thoughts;
  String timestamp;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnMood: mood,
      columnThoughts: thoughts,
      columnTimestamp: timestamp,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  LifelogEntity({
    this.id,
    @required this.mood,
    @required this.thoughts,
    @required this.timestamp,
  });

  LifelogEntity.fromMap(Map<String, dynamic> map)
      : id = map[columnId],
        mood = map[columnMood],
        thoughts = map[columnThoughts],
        timestamp = map[columnTimestamp];
}
