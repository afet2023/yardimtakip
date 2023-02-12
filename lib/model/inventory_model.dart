import 'dart:convert';

class InventoryModel {
  final String inventoryId;
  final int quantity;
  InventoryModel({
    required this.inventoryId,
    required this.quantity,
  });

  InventoryModel copyWith({
    String? inventoryId,
    int? quantity,
  }) {
    return InventoryModel(
      inventoryId: inventoryId ?? this.inventoryId,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'inventoryId': inventoryId});
    result.addAll({'quantity': quantity});

    return result;
  }

  factory InventoryModel.fromMap(Map map) {
    return InventoryModel(
      inventoryId: map['inventoryId'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }
// fake  model
  factory InventoryModel.fake() => InventoryModel(
        inventoryId: '1',
        quantity: 1,
      );
  String toJson() => json.encode(toMap());

  factory InventoryModel.fromJson(String source) =>
      InventoryModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'InventoryModel(inventoryId: $inventoryId, quantity: $quantity)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InventoryModel &&
        other.inventoryId == inventoryId &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => inventoryId.hashCode ^ quantity.hashCode;
}
