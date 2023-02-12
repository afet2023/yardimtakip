part of 'eathquake_bloc.dart';

abstract class EathquakeEvent extends Equatable {
  const EathquakeEvent();

  @override
  List<Object> get props => [];
}

class EathquakeLoadEvent extends EathquakeEvent {}
