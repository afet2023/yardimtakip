import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yardimtakip/model/inventory_model.dart';

class FormModel {
  final String id;
  final String earthquakeVictimsId;
  final List<InventoryModel> inventories;
  final String createdAt;

  FormModel({
    required this.id,
    required this.earthquakeVictimsId,
    required this.inventories,
    required this.createdAt,
  });

  FormModel copyWith({
    String? id,
    String? earthquakeVictimsId,
    List<InventoryModel>? inventories,
    String? createdAt,
  }) {
    return FormModel(
      id: id ?? this.id,
      earthquakeVictimsId: earthquakeVictimsId ?? this.earthquakeVictimsId,
      inventories: inventories ?? this.inventories,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'earthquakeVictimsId': earthquakeVictimsId});
    result.addAll({'inventories': inventories.map((x) => x.toMap()).toList()});
    result.addAll({'createdAt': createdAt});

    return result;
  }

  factory FormModel.fromMap(Map<String, dynamic> map) {
    return FormModel(
      id: map['id'] ?? '',
      earthquakeVictimsId: map['earthquakeVictimsId'] ?? '',
      inventories: List<InventoryModel>.from(
          map['inventories']?.map((x) => InventoryModel.fromMap(x))),
      createdAt: map['createdAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FormModel.fromJson(String source) =>
      FormModel.fromMap(json.decode(source));
// fake data
  factory FormModel.fake() => FormModel(
        id: '1',
        earthquakeVictimsId: '1',
        inventories: [
          InventoryModel.fake(),
          InventoryModel.fake(),
        ],
        createdAt: DateTime.now().toString(),
      );
  @override
  String toString() {
    return 'FormModel(id: $id, earthquakeVictimsId: $earthquakeVictimsId, inventories: $inventories, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FormModel &&
        other.id == id &&
        other.earthquakeVictimsId == earthquakeVictimsId &&
        listEquals(other.inventories, inventories) &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        earthquakeVictimsId.hashCode ^
        inventories.hashCode ^
        createdAt.hashCode;
  }
}
