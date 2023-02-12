part of 'inventory_bloc.dart';

abstract class InventoryEvent extends Equatable {
  const InventoryEvent();

  @override
  List<Object> get props => [];
}

class InventoryLoadEvent extends InventoryEvent {}

class InventoryClearEvent extends InventoryEvent {
  String? message;

  InventoryClearEvent([this.message]);
}

class InventoryAddNewEntryEvent extends InventoryEvent {
  final EarthquakeVictims earthquakeVictims;

  InventoryAddNewEntryEvent(this.earthquakeVictims);
  @override
  List<Object> get props => [earthquakeVictims];
}
