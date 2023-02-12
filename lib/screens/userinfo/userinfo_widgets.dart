

import 'package:flutter/material.dart';
import 'package:yardimtakip/screens/userinfo/userinfo_constant.dart';

class UserInfoWidgets{

  Widget nextButton() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        onTap: () {
          print(UserInfoConstants.nameSurnameController);
        },
        child: Container(
          alignment: Alignment.center,
          height: 50,
          width: 374,
          decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(6)),
          child:const Text('Devam Et',style:  TextStyle(fontSize: 20,color: Colors.white),),
      
        ),
      ),
      
    );
  }


  Widget textFieldWidgets () {
    return SizedBox(
      height: 320,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(6.0),
          child: TextField(
            controller:UserInfoConstants().userControllers[index],
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: UserInfoConstants().userInfoTexts[index]
            ),
            
          ),
        );
      
        
      },),
    );
  }

  Widget defaultVerticalPadding() {
    return const Padding(padding: EdgeInsets.symmetric(vertical: 4));
  }
  Widget defaultAllPadding() {
    return const Padding(padding: EdgeInsets.all(10.0));
  }
  Widget redContainer() {
    return  Container(
      height: 50,width: 70, color: Colors.red,
    );
  }
}