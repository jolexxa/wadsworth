import 'package:equatable/equatable.dart';
import 'package:lifelog_repo/lifelog_repo.dart';

enum Mood {
  /// Something like 😡 or 😢
  Bad,

  /// Something like 😐 or 🤷‍♀️
  Meh,

  /// 😁
  Good,
}

class Lifelog extends Equatable {
  static int _instances = 1;

  final int id;
  final int dbId;
  final Mood mood;
  final String thoughts;
  final DateTime timestamp;

  @override
  List<Object> get props => [id, mood, thoughts];

  Lifelog copyWith({
    Mood mood,
    String thoughts,
  }) {
    return Lifelog(
      mood: mood ?? this.mood,
      thoughts: thoughts ?? this.thoughts,
      timestamp: timestamp,
    );
  }

  Lifelog({
    this.mood = Mood.Meh,
    this.thoughts = '',
    this.timestamp,
    this.dbId,
  }) : id = _instances++;

  LifelogEntity toEntity() {
    return LifelogEntity(
      id: dbId,
      mood: mood.index,
      thoughts: thoughts,
      timestamp:
          timestamp?.toIso8601String() ?? DateTime.now().toIso8601String(),
    );
  }

  static Lifelog fromEntity(LifelogEntity entity) {
    return Lifelog(
      dbId: entity.id,
      mood: Mood.values[entity.mood],
      thoughts: entity.thoughts,
      timestamp: DateTime.parse(entity.timestamp),
    );
  }
}
