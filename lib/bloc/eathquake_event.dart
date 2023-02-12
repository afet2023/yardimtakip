part of 'eathquake_bloc.dart';

abstract class EathquakeEvent extends Equatable {
  const EathquakeEvent();

  @override
  List<Object> get props => [];
}

class EathquakeLoadEvent extends EathquakeEvent {}

class EathquakeLoadDetailEvent extends EathquakeEvent {
  final String id;
  EathquakeLoadDetailEvent(this.id);
}

class EathquakeClearDetailEvent extends EathquakeEvent {}
