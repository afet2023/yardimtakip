import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kartal/kartal.dart';
import 'package:yardimtakip/screens/user_profile/user_profile.widgets.dart';

import '../../bloc/authentication_bloc.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var iconProfile;
    var length;
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Center(
              child: Text(
            "Profile",
            style: context.textTheme.bodyLarge!.copyWith(
              color: context.colorScheme.onPrimary,
            ),
          )),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
          child: Column(
            children: [
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(
                  'assets/svg/gsb.svg',
                  color: Colors.black87,
                  key: const Key('gsbLogo'),
                ),
              ),
              Stylesizedbox(
                uzun: 20,
              ),
              StyleText(
                Name: "Muhammed Şen",
                weight: FontWeight.w500,
                size: 18,
                renk: Color(0xFF181718),
              ),
              Stylesizedbox(uzun: 8),
              StyleText(
                  Name: "Gönüllü",
                  weight: FontWeight.w400,
                  size: 14,
                  renk: Color(0xFF9E9E9E)),
              Stylesizedbox(uzun: 10),
              ProfilItem(
                  iconData: Icons.person_outline,
                  text: "Hesap Bilgileri",
                  onTap: () {}),
              Divider(
                height: 1,
                thickness: 1,
              ),
              ProfilItem(
                  iconData: Icons.contact_support_outlined,
                  text: "Destek ve Şikayet",
                  onTap: () {}),
              Divider(
                height: 1,
                thickness: 1,
              ),
              ProfilItem(
                  iconData: Icons.rule,
                  text: "Kullanım Koşulları",
                  onTap: () {}),
              Divider(
                height: 1,
                thickness: 1,
              ),
              ExitlItem(
                  onTap: () {
                    context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationLogoutEvent());
                  },
                  text: "Çıkış"),
              Divider(
                height: 1,
                thickness: 1,
              ),
            ],
          ),
        ));
  }
}
