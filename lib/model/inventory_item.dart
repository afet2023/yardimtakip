import 'dart:convert';

class InventoryItemModel {
  final String id;
  final String name;
  final String description;
  int quantity = 0;
  InventoryItemModel({
    required this.id,
    required this.name,
    required this.description,
  });

  InventoryItemModel copyWith({
    String? id,
    String? name,
    String? description,
  }) {
    return InventoryItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'description': description});

    return result;
  }

//firebase snapshot
  factory InventoryItemModel.fromMap(Map map) {
    return InventoryItemModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryItemModel.fromJson(String source) =>
      InventoryItemModel.fromMap(json.decode(source));
//fake
  factory InventoryItemModel.fake() => InventoryItemModel(
        id: '1',
        name: '1',
        description: '1',
      );
  @override
  String toString() =>
      'InventoryItemModel(id: $id, name: $name, description: $description)';

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
}
