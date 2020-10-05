import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wadsworth/models/models.dart';
import 'package:wadsworth/repos/repos.dart';

part 'lifelog_event.dart';
part 'lifelog_state.dart';

class LifelogBloc extends Bloc<LifelogEvent, LifelogState> {
  final LifelogRepo repo;

  LifelogBloc({@required this.repo}) : super(LifelogStateLoading());

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
    await repo.addLifelog(event.lifelog);
    // SOMEDAY: Keep local cache for the sake of performance instead of reloading
    // everything
    add(LifelogReloadRequested());
  }

  Stream<LifelogState> _mapLifelogRemovedToState(LifelogRemoved event) async* {
    await repo.deleteLifelog(event.lifelog);
    add(LifelogReloadRequested());
  }

  Stream<LifelogState> _mapLifelogReloadRequestedToState(
      LifelogReloadRequested event) async* {
    try {
      final lifelogs = await repo.getAllLifelogs();
      yield LifelogStateLoadSuccess(lifelogs: lifelogs);
    } catch (e) {
      yield LifelogStateLoadFailure();
    }
  }
}
