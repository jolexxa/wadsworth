part of 'lifelog_bloc.dart';

abstract class LifelogState extends Equatable {
  const LifelogState();

  @override
  List<Object> get props => [];
}

class LifelogStateLoading extends LifelogState {}

class LifelogStateLoadFailure extends LifelogState {}

class LifelogStateLoadSuccess extends LifelogState {
  const LifelogStateLoadSuccess({@required this.lifelogs});

  /// List of entries in order of listing
  final List<Lifelog> lifelogs;

  @override
  List<Object> get props => [lifelogs];
}
