import 'dart:convert';

class VolunteerModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String district;
  final String description;
  final String createdAt;
  final String updatedAt;
  VolunteerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.district,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  VolunteerModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? city,
    String? district,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) {
    return VolunteerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      city: city ?? this.city,
      district: district ?? this.district,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'phone': phone});
    result.addAll({'address': address});
    result.addAll({'city': city});
    result.addAll({'district': district});
    result.addAll({'description': description});
    result.addAll({'createdAt': createdAt});
    result.addAll({'updatedAt': updatedAt});

    return result;
  }

  factory VolunteerModel.fromMap(Map map) {
    return VolunteerModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      district: map['district'] ?? '',
      description: map['description'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }
  //fake model
  factory VolunteerModel.fake() {
    return VolunteerModel(
      id: '1',
      name: 'Test soyadı',
      email: 'test@gmail.com',
      phone: '0123456789',
      address: 'Adres',
      city: 'Hatay',
      district: 'Antakya',
      description: 'Tanım',
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory VolunteerModel.fromJson(String source) =>
      VolunteerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VolunteerModel(id: $id, name: $name, email: $email, phone: $phone, address: $address, city: $city, district: $district, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VolunteerModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.address == address &&
        other.city == city &&
        other.district == district &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        address.hashCode ^
        city.hashCode ^
        district.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
