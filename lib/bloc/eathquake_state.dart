part of 'eathquake_bloc.dart';

enum EathquakeStatus { initial, loading, loaded, error, success }

class EathquakeState extends Equatable {
  EathquakeState({
    this.status = EathquakeStatus.initial,
    this.earthquakeVictims = const [],
    this.earthquakeVictimsAll = const [],
  });
  final EathquakeStatus status;
  final List<EarthquakeVictims> earthquakeVictims;
  final List<EarthquakeVictims> earthquakeVictimsAll;
  @override
  List<Object> get props => [earthquakeVictims, earthquakeVictimsAll];

  EathquakeState copyWith({
    EathquakeStatus? status,
    List<EarthquakeVictims>? earthquakeVictims,
    List<EarthquakeVictims>? earthquakeVictimsAll,
  }) {
    return EathquakeState(
      status: status ?? this.status,
      earthquakeVictims: earthquakeVictims ?? this.earthquakeVictims,
      earthquakeVictimsAll: earthquakeVictimsAll ?? this.earthquakeVictimsAll,
    );
  }
}
