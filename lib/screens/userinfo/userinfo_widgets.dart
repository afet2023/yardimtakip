import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:yardimtakip/constants.dart';
import 'package:yardimtakip/extensions/context_extension.dart';
import 'package:yardimtakip/model/earthquake_victims_model.dart';
import 'package:yardimtakip/model/inventory_category_model.dart';
import 'package:yardimtakip/model/inventory_item.dart';
import 'package:yardimtakip/screens/home/home_cubit.dart';
import 'package:yardimtakip/screens/userinfo/userinfo_constant.dart';

import '../../repository/firebase_auth_repository.dart';
import '../../repository/network_repository.dart';

class UserInfoWidgets {
  Widget nextButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: BlocBuilder<HomeCubit, HomeCubitState>(
        builder: (context, state) {
          return SizedBox(
            width: context.getDynamicWidth(100),
            height: context.getDynamicHeight(6),
            child: ElevatedButton(
              onPressed: !state.isContinueButtonEnabled ? null : () async {
                var earthquakeVictims = EarthquakeVictims(
                  id: const Uuid().v4(),
                  nameAndSurname: UserInfoConstants.nameSurnameController.text,
                  phoneNumber: UserInfoConstants.phoneNumberController.text,
                  createdAt: DateTime.now().toIso8601String(),
                  createdByVolunteerId:
                      context.read<FirebaseAuthRepository>().getCurrentUser!.uid,
                  uid: UserInfoConstants.citizenNumberController.text,
                  city: UserInfoConstants.cityController.text,
                  familyCount: int.parse(
                      UserInfoConstants.numOfPersonController.text.isEmpty
                          ? '0'
                          : UserInfoConstants.numOfPersonController.text),
                );

                Navigator.pushNamed(context, '/inventory',
                    arguments: earthquakeVictims);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red
              ),
              child: const Text(
                'Devam Et',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          );
        }
      ),
    );
  }

  Widget textFieldWidgets() {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextField(
              controller: UserInfoConstants().userControllers[index],
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: UserInfoConstants().userInfoTexts[index]),
            ),
          );
        },
      ),
    );
  }

  Widget defaultVerticalPadding() {
    return const Padding(padding: EdgeInsets.symmetric(vertical: 4));
  }

  Widget defaultAllPadding() {
    return const Padding(padding: EdgeInsets.all(10.0));
  }

  Widget redContainer() {
    return Container(
      height: 50,
      width: 70,
      color: Colors.red,
    );
  }
}
