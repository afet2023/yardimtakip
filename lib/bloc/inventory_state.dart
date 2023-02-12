part of 'inventory_bloc.dart';

abstract class InventoryState extends Equatable {
  const InventoryState();

  @override
  List<Object> get props => [];
}

class InventoryInitial extends InventoryState {}

class InventoryLoading extends InventoryState {}

class InventoryLoaded extends InventoryState {
  final List<InventoryCategoryModel> inventoryCategories;
  InventoryLoaded(this.inventoryCategories);
}

class InventoryError extends InventoryState {}
