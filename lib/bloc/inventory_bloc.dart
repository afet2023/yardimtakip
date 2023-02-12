import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'package:yardimtakip/model/earthquake_victims_model.dart';
import 'package:yardimtakip/model/inventory_category_model.dart';
import 'package:yardimtakip/model/inventory_model.dart';
import 'package:yardimtakip/repository/firebase_auth_repository.dart';

import '../model/form_model.dart';
import '../repository/network_repository.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final INetworkRepository networkRepository;
  final FirebaseAuthRepository authRepository;
  InventoryBloc(this.networkRepository, this.authRepository)
      : super(InventoryInitial()) {
    on<InventoryEvent>((event, emit) {});
    on<InventoryLoadEvent>(_onLoadEvent);
    on<InventoryClearEvent>(_onClearEvent);
    on<InventoryAddNewEntryEvent>(_onAddNewEntryEvent);
  }

  Future<FutureOr<void>> _onLoadEvent(
      InventoryLoadEvent event, Emitter<InventoryState> emit) async {
    try {
      emit(InventoryLoading());
      var data = await networkRepository.getAllInventoryCategories();
      emit(InventoryLoaded(data));
    } catch (e) {
      emit(InventoryError(message: 'Bir hata oluştu.'));
    }
  }

  FutureOr<void> _onClearEvent(
      InventoryClearEvent event, Emitter<InventoryState> emit) {
    try {
      if (state is InventoryLoaded) {
        var data = (state as InventoryLoaded).inventoryCategories;
        for (var item in data) {
          for (var element in item.inventoryItems) {
            element.quantity = 0;
          }
        }
        emit(InventoryInitial());
        emit(InventoryLoaded(data));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<FutureOr<void>> _onAddNewEntryEvent(
      InventoryAddNewEntryEvent event, Emitter<InventoryState> emit) async {
    try {
      if (state is InventoryLoaded) {
        var data = (state as InventoryLoaded).inventoryCategories;
        var inventoryModels = <InventoryModel>[];
        for (var item in data) {
          for (var element in item.inventoryItems) {
            element.quantity = 0;
            inventoryModels.add(InventoryModel(
                inventoryId: element.id, quantity: element.quantity));
          }
        }
        var form = FormModel(
            id: Uuid().v4(),
            createdByVolunteerId: authRepository.getCurrentUser!.uid,
            earthquakeVictimsId: event.earthquakeVictims.id,
            inventories: inventoryModels,
            createdAt: DateTime.now().toIso8601String());
        await networkRepository.addEarthquakeVictims(event.earthquakeVictims);
        await networkRepository.addForm(form);
        emit(InventorySuccess(
            'Kayıt başarıyla eklendi. ${event.earthquakeVictims.nameAndSurname} kişisine yardım başarıyla verildi.'));
        await Future.delayed(Duration(milliseconds: 800));
        await _onClearEvent(InventoryClearEvent(), emit);
      }
    } catch (e) {
      emit(InventoryError(message: 'Bir hata oluştu.'));
    }
  }
}
