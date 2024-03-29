import 'dart:convert';

import 'package:equatable/equatable.dart';

class InventoryItemModel extends Equatable {
  final String id;
  final String name;
  final String description;
  int quantity = 0;
  InventoryItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.quantity,
  });

  InventoryItemModel copyWith({
    String? id,
    String? name,
    String? description,
    int? quantity,
  }) {
    return InventoryItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'quantity': quantity});
  
    return result;
  }

//firebase snapshot
  factory InventoryItemModel.fromMap(Map map) {
    return InventoryItemModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryItemModel.fromJson(String source) =>
      InventoryItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InventoryItemModel(id: $id, name: $name, description: $description, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InventoryItemModel &&
        other.id == id &&
        other.name == name &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode;

  @override
  List<Object> get props => [id, name, description, quantity];
}
