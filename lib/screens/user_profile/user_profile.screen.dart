import 'package:flutter/material.dart';
import 'package:yardimtakip/screens/user_profile/user_profile.widgets.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var iconProfile;
    var length;
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Profile",
              style: TextStyle(color: Colors.black),
            ),
          ),
          elevation: 0.2,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/AFAD_logo.png/1200px-AFAD_logo.png"),
                          fit: BoxFit.fill)),
                ),
              ),
              Stylesizedbox(
                uzun: 20,
              ),
              StyleText(
                Name: "Muhammed Şen",
              ),
              Stylesizedbox(uzun: 8),
              StyleText(Name: "Gönüllü"),
              ProfilItem(
                  iconData: Icons.person_outline,
                  text: "Hesap Bilgileri",
                  onTap: () {}),
              Divider(),
              ProfilItem(
                  iconData: Icons.contact_support_outlined,
                  text: "Destek ve Şikayet",
                  onTap: () {}),
              Divider(),
              ProfilItem(
                  iconData: Icons.rule,
                  text: "Kullanım Koşulları",
                  onTap: () {}),
              Divider(),
              ProfilItem(
                  iconData: Icons.exit_to_app, text: "Çıkış", onTap: () {}),
              Divider(),
            ],
          ),
        ));
  }
}
