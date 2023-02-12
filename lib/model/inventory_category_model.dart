import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'inventory_item.dart';
import 'inventory_model.dart';

class InventoryCategoryModel {
  String id;
  String name;

  List<InventoryItemModel> inventoryItems;
  String createdAt;
  String updatedAt;
  InventoryCategoryModel({
    required this.id,
    required this.name,
    required this.inventoryItems,
    required this.createdAt,
    required this.updatedAt,
  });

  InventoryCategoryModel copyWith({
    String? id,
    String? name,
    List<InventoryItemModel>? inventoryItems,
    String? createdAt,
    String? updatedAt,
  }) {
    return InventoryCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      inventoryItems: inventoryItems ?? this.inventoryItems,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll(
        {'inventoryItems': inventoryItems.map((x) => x.toMap()).toList()});
    result.addAll({'createdAt': createdAt});
    result.addAll({'updatedAt': updatedAt});

    return result;
  }

  factory InventoryCategoryModel.fromMap(Map map) {
    return InventoryCategoryModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      inventoryItems: List<InventoryItemModel>.from(
          map['inventoryItems']?.map((x) => InventoryItemModel.fromMap(x))),
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryCategoryModel.fromJson(String source) =>
      InventoryCategoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InventoryCategoryModel(id: $id, name: $name, inventoryItems: $inventoryItems, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InventoryCategoryModel &&
        other.id == id &&
        other.name == name &&
        listEquals(other.inventoryItems, inventoryItems) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        inventoryItems.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
