import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yardimtakip/model/inventory_model.dart';

class FormModel {
  final String id;
  final String name;
  final String phone;
  final String voluntaryId;
  final String uid;
  final String address;
  final String city;
  final String district;
  final String description;
  final List<InventoryModel> inventories;
  final String createdAt;
  final String updatedAt;
  FormModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.voluntaryId,
    required this.uid,
    required this.address,
    required this.city,
    required this.district,
    required this.description,
    required this.inventories,
    required this.createdAt,
    required this.updatedAt,
  });

  FormModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? voluntaryId,
    String? uid,
    String? address,
    String? city,
    String? district,
    String? description,
    List<InventoryModel>? inventories,
    String? createdAt,
    String? updatedAt,
  }) {
    return FormModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      voluntaryId: voluntaryId ?? this.voluntaryId,
      uid: uid ?? this.uid,
      address: address ?? this.address,
      city: city ?? this.city,
      district: district ?? this.district,
      description: description ?? this.description,
      inventories: inventories ?? this.inventories,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'phone': phone});
    result.addAll({'voluntaryId': voluntaryId});
    result.addAll({'uid': uid});
    result.addAll({'address': address});
    result.addAll({'city': city});
    result.addAll({'district': district});
    result.addAll({'description': description});
    result.addAll({'inventories': inventories.map((x) => x.toMap()).toList()});
    result.addAll({'createdAt': createdAt});
    result.addAll({'updatedAt': updatedAt});

    return result;
  }

  factory FormModel.fromMap(Map map) {
    return FormModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      voluntaryId: map['voluntaryId'] ?? '',
      uid: map['uid'] ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      district: map['district'] ?? '',
      description: map['description'] ?? '',
      inventories: List<InventoryModel>.from(
          map['inventories']?.map((x) => InventoryModel.fromMap(x))),
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FormModel.fromJson(String source) =>
      FormModel.fromMap(json.decode(source));
// fake data
  factory FormModel.fake() => FormModel(
        id: '1',
        name: 'name',
        phone: '012345678',
        voluntaryId: 'voluntaryId',
        uid: 'uid',
        address: 'address',
        city: 'city',
        district: 'district',
        description: 'description',
        inventories: [
          InventoryModel.fake(),
          InventoryModel.fake(),
        ],
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
      );
  @override
  String toString() {
    return 'FormModel(id: $id, name: $name, phone: $phone, voluntaryId: $voluntaryId, uid: $uid, address: $address, city: $city, district: $district, description: $description, inventories: $inventories, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FormModel &&
        other.id == id &&
        other.name == name &&
        other.phone == phone &&
        other.voluntaryId == voluntaryId &&
        other.uid == uid &&
        other.address == address &&
        other.city == city &&
        other.district == district &&
        other.description == description &&
        listEquals(other.inventories, inventories) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        voluntaryId.hashCode ^
        uid.hashCode ^
        address.hashCode ^
        city.hashCode ^
        district.hashCode ^
        description.hashCode ^
        inventories.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
