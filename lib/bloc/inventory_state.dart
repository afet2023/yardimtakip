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

  @override
  List<Object> get props => [
        inventoryCategories
            .map((e) => e.inventoryItems.map((e) => e.quantity).toList())
            .toList()
      ];
}

class InventoryError extends InventoryState {
  String message;
  InventoryError({
    required this.message,
  });
}

class InventorySuccess extends InventoryState {
  final String message;
  InventorySuccess(this.message);

  @override
  List<Object> get props => [message];
}
