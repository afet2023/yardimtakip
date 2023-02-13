import 'dart:convert';

import 'package:flutter/foundation.dart';

class EarthquakeVictims {
  final String id;
  final String nameAndSurname;
  final String phoneNumber;
  final String createdByVolunteerId;
  final String createdAt;
  final String uid;
  final String city;
  final List<String> familyIds;
  EarthquakeVictims({
    required this.id,
    required this.nameAndSurname,
    required this.phoneNumber,
    required this.createdByVolunteerId,
    required this.createdAt,
    required this.uid,
    required this.city,
    required this.familyIds,
  });

  EarthquakeVictims copyWith({
    String? id,
    String? nameAndSurname,
    String? phoneNumber,
    String? createdByVolunteerId,
    String? createdAt,
    String? uid,
    String? city,
    List<String>? familyIds,
  }) {
    return EarthquakeVictims(
      id: id ?? this.id,
      nameAndSurname: nameAndSurname ?? this.nameAndSurname,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdByVolunteerId: createdByVolunteerId ?? this.createdByVolunteerId,
      createdAt: createdAt ?? this.createdAt,
      uid: uid ?? this.uid,
      city: city ?? this.city,
      familyIds: familyIds ?? this.familyIds,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'nameAndSurname': nameAndSurname});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'createdByVolunteerId': createdByVolunteerId});
    result.addAll({'createdAt': createdAt});
    result.addAll({'uid': uid});
    result.addAll({'city': city});
    result.addAll({'familyIds': familyIds});

    return result;
  }

  factory EarthquakeVictims.fromMap(Map map) {
    return EarthquakeVictims(
      id: map['id'] ?? '',
      nameAndSurname: map['nameAndSurname'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createdByVolunteerId: map['createdByVolunteerId'] ?? '',
      createdAt: map['createdAt'] ?? '',
      uid: map['uid'] ?? '',
      city: map['city'] ?? '',
      familyIds: List<String>.from(map['familyIds']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EarthquakeVictims.fromJson(String source) =>
      EarthquakeVictims.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EarthquakeVictims(id: $id, nameAndSurname: $nameAndSurname, phoneNumber: $phoneNumber, createdByVolunteerId: $createdByVolunteerId, createdAt: $createdAt, uid: $uid, city: $city, familyIds: $familyIds)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EarthquakeVictims &&
        other.id == id &&
        other.nameAndSurname == nameAndSurname &&
        other.phoneNumber == phoneNumber &&
        other.createdByVolunteerId == createdByVolunteerId &&
        other.createdAt == createdAt &&
        other.uid == uid &&
        other.city == city &&
        listEquals(other.familyIds, familyIds);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nameAndSurname.hashCode ^
        phoneNumber.hashCode ^
        createdByVolunteerId.hashCode ^
        createdAt.hashCode ^
        uid.hashCode ^
        city.hashCode ^
        familyIds.hashCode;
  }
}
