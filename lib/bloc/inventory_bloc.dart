import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yardimtakip/model/inventory_category_model.dart';

import '../repository/network_repository.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final INetworkRepository networkRepository;
  InventoryBloc(this.networkRepository) : super(InventoryInitial()) {
    on<InventoryEvent>((event, emit) {});
    on<InventoryLoadEvent>(_onLoadEvent);
  }

  Future<FutureOr<void>> _onLoadEvent(
      InventoryLoadEvent event, Emitter<InventoryState> emit) async {
    try {
      emit(InventoryLoading());
      var data = await networkRepository.getAllInventoryCategories();
      emit(InventoryLoaded(data));
    } catch (e) {
      emit(InventoryError());
    }
  }
}
