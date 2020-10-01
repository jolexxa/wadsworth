import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wadsworth/models/models.dart';
import 'package:lifelog_repo/lifelog_repo.dart';

part 'lifelog_event.dart';
part 'lifelog_state.dart';

class LifelogBloc extends Bloc<LifelogEvent, LifelogState> {
  final LifelogClient lifelogClient;

  LifelogBloc({@required this.lifelogClient}) : super(LifelogStateLoading());

  @override
  Stream<LifelogState> mapEventToState(
    LifelogEvent event,
  ) async* {
    if (event is LifelogAdded) {
      yield* _mapLifelogAddedToState(event);
    } else if (event is LifelogRemoved) {
      yield* _mapLifelogRemovedToState(event);
    } else if (event is LifelogReloadRequested) {
      yield* _mapLifelogReloadRequestedToState(event);
    }
  }

  Stream<LifelogState> _mapLifelogAddedToState(LifelogAdded event) async* {
    await lifelogClient.insert(event.lifelog.toEntity());
  }

  Stream<LifelogState> _mapLifelogRemovedToState(LifelogRemoved event) async* {
    await lifelogClient.delete(event.lifelog.dbId);
  }

  Stream<LifelogState> _mapLifelogReloadRequestedToState(
      LifelogReloadRequested event) async* {
    final lifelogs = (await lifelogClient.all())
        .map((lifelogEntity) => Lifelog.fromEntity(lifelogEntity))
        .toList();
    yield LifelogStateLoadSuccess(lifelogs: lifelogs);
  }
}
