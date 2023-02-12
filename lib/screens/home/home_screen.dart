import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:yardimtakip/bloc/authentication_bloc.dart';
import 'package:yardimtakip/bloc/eathquake_bloc.dart';

import 'package:yardimtakip/repository/network_repository.dart';
import 'package:yardimtakip/screens/earthquake_victims_list/earthquake_victims_list_screen.dart';
import 'package:yardimtakip/screens/user_profile/user_profile.screen.dart';
import 'package:yardimtakip/screens/userinfo/userinfo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    context.read<EathquakeBloc>().add(EathquakeLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.unauthenticated) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/sign_in', (Route<dynamic> route) => false);
        }
      },
      child: Scaffold(
        body: currentIndex == 0
            ? UserSaveInfo()
            : currentIndex == 1
                ? EarthquakeVictimsListScreen()
                : UserProfileScreen(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.real_estate_agent_outlined),
              label: 'Deprem Mağdurları',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
