import 'dart:convert';

class VolunteerModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  String? address;
  String? city;
  String? district;
  String? description;
  String? createdAt;
  final bool isVerified;
  String? updatedAt;
  VolunteerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.address,
    this.city,
    this.district,
    this.description,
    this.createdAt,
    required this.isVerified,
    this.updatedAt,
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
    bool? isVerified,
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
      isVerified: isVerified ?? this.isVerified,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'phone': phone});
    if (address != null) {
      result.addAll({'address': address});
    }
    if (city != null) {
      result.addAll({'city': city});
    }
    if (district != null) {
      result.addAll({'district': district});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (createdAt != null) {
      result.addAll({'createdAt': createdAt});
    }
    result.addAll({'isVerified': isVerified});
    if (updatedAt != null) {
      result.addAll({'updatedAt': updatedAt});
    }

    return result;
  }

  factory VolunteerModel.fromMap(Map map) {
    return VolunteerModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'],
      city: map['city'],
      district: map['district'],
      description: map['description'],
      createdAt: map['createdAt'],
      isVerified: map['isVerified'] ?? false,
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VolunteerModel.fromJson(String source) =>
      VolunteerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VolunteerModel(id: $id, name: $name, email: $email, phone: $phone, address: $address, city: $city, district: $district, description: $description, createdAt: $createdAt, isVerified: $isVerified, updatedAt: $updatedAt)';
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
        other.isVerified == isVerified &&
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
        isVerified.hashCode ^
        updatedAt.hashCode;
  }
}
