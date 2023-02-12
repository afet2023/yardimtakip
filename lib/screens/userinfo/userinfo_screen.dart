


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:yardimtakip/screens/userinfo/userinfo_constant.dart';
import 'package:yardimtakip/screens/userinfo/userinfo_widgets.dart';

class UserSaveInfo extends StatelessWidget with UserInfoWidgets{
  const UserSaveInfo
({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Depremzede Kaydı Oluştur',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(      
          children: [
            defaultAllPadding(),
            redContainer(),
            defaultAllPadding(),
            Text('Depremzede Kaydı İki Adımdan Oluşmaktadır',style:  TextStyle(fontSize: 12,color: Colors.black.withOpacity(0.5)),),
            Text('Birinci Adım Kişisel Bilgiler diğer Adım ise İhtiyaç Listesidir',style:  TextStyle(fontSize: 12,color: Colors.black.withOpacity(0.5)),),
            defaultVerticalPadding(),
            textFieldWidgets(),
            defaultVerticalPadding(),
            nextButton()
          ],
        ),
      ),
    );
  }
}




