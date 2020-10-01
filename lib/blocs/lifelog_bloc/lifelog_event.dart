part of 'lifelog_bloc.dart';

@immutable
abstract class LifelogEvent extends Equatable {
  const LifelogEvent();
  @override
  List<Object> get props => [];
}

@immutable
abstract class LifelogPayloadEvent extends LifelogEvent {
  final Lifelog lifelog;

  const LifelogPayloadEvent(this.lifelog);

  @override
  List<Object> get props => [lifelog];
}

@immutable
class LifelogReloadRequested extends LifelogEvent {}

@immutable
class LifelogAdded extends LifelogPayloadEvent {
  const LifelogAdded(Lifelog lifelog) : super(lifelog);
}

@immutable
class LifelogRemoved extends LifelogPayloadEvent {
  const LifelogRemoved(Lifelog lifelog) : super(lifelog);
}

@immutable
class LifelogUpdated extends LifelogPayloadEvent {
  const LifelogUpdated(Lifelog lifelog) : super(lifelog);
}
