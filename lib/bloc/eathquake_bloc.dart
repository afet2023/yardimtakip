import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/earthquake_victims_model.dart';
import '../repository/network_repository.dart';

part 'eathquake_event.dart';
part 'eathquake_state.dart';

class EathquakeBloc extends Bloc<EathquakeEvent, EathquakeState> {
  final INetworkRepository networkRepository;
  EathquakeBloc(this.networkRepository) : super(EathquakeState()) {
    on<EathquakeEvent>((event, emit) {});
    on<EathquakeLoadEvent>(_onLoadEvent);
  }

  Future<FutureOr<void>> _onLoadEvent(
      EathquakeLoadEvent event, Emitter<EathquakeState> emit) async {
    try {
      emit(EathquakeState(status: EathquakeStatus.loading));
      var data = await networkRepository
          .getAllEarthquakeVictimsById(FirebaseAuth.instance.currentUser!.uid);
      var dataAll = await networkRepository.getAllEarthquakeVictims();

      emit(EathquakeState(
        status: EathquakeStatus.loaded,
        earthquakeVictims: data,
        earthquakeVictimsAll: dataAll,
      ));
    } catch (e) {
      print(e);
    }
  }
}
