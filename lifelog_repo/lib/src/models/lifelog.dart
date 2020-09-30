class Lifelog {
  static final String columnId = '_id';
  static final String columnMood = 'mood';
  static final String columnThoughts = 'thoughts';

  int id;
  int mood;
  String thoughts;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnMood: mood,
      columnThoughts: thoughts,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Lifelog();

  Lifelog.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    mood = map[columnMood];
    thoughts = map[columnThoughts];
  }
}
