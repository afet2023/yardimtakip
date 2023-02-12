import 'package:flutter/material.dart';

class UserInfoConstants {
  factory UserInfoConstants() => _instance;
  UserInfoConstants._internal();
  static final UserInfoConstants _instance = UserInfoConstants._internal();
  static TextEditingController nameSurnameController = TextEditingController();
  static TextEditingController citizenNumberController =
      TextEditingController();
  static TextEditingController phoneNumberController = TextEditingController();
  static TextEditingController cityController = TextEditingController();
  static TextEditingController numOfPersonController = TextEditingController();

  List<String> userInfoTexts = [
    'Ad Soyad',
    'Kimlik Numarası',
    'Telefon Numarası',
    'Geldiği Şehir',
    'Kişi Sayısı'
  ];

  List<TextEditingController> userControllers = [
    nameSurnameController,
    citizenNumberController,
    phoneNumberController,
    cityController,
    numOfPersonController
  ];
}
