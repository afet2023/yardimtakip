import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kartal/kartal.dart';
import 'package:yardimtakip/screens/userinfo/userinfo_constant.dart';

import 'userinfo_widgets.dart';

class UserSaveInfo extends StatelessWidget with UserInfoWidgets {
  const UserSaveInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Depremzede Kaydı Oluştur',
            style: context.textTheme.bodyLarge!.copyWith(
              color: context.colorScheme.onPrimary,
            )),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.recycling),
            onPressed: () {
              UserInfoConstants().userControllers.forEach((element) {
                element.text = '';
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            defaultAllPadding(),
            defaultAllPadding(),
            Text(
              'Depremzede Kaydı İki Adımdan Oluşmaktadır',
              style:
                  TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.5)),
            ),
            Text(
              'Birinci Adım Kişisel Bilgiler diğer Adım ise İhtiyaç Listesidir',
              style:
                  TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.5)),
            ),
            defaultVerticalPadding(),
            textFieldWidgets(),
            defaultVerticalPadding(),
            nextButton(context),
            SizedBox(height: 60)
          ],
        ),
      ),
    );
  }
}
