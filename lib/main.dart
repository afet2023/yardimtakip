import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:yardimtakip/bloc/eathquake_bloc.dart';

import 'package:yardimtakip/firebase_options.dart';
import 'package:yardimtakip/repository/firebase_auth_repository.dart';
import 'package:yardimtakip/repository/network_repository.dart';
import 'package:yardimtakip/screens/auth/login_screen.dart';
import 'package:yardimtakip/screens/auth/register_screen.dart';
import 'package:yardimtakip/screens/conditions/conditions_screen.dart';
import 'package:yardimtakip/screens/earthquake_victims_list/earthquake_victims_detail_screen.dart';
import 'package:yardimtakip/screens/earthquake_victims_list/earthquake_victims_list_screen.dart';
import 'package:yardimtakip/screens/entry_inventory/entry_inventory_screen.dart';
import 'package:yardimtakip/screens/home/home_screen.dart';

import 'package:yardimtakip/screens/user_profile/user_profile.screen.dart';

import 'package:yardimtakip/screens/userinfo/userinfo_screen.dart';

import 'bloc/authentication_bloc.dart';

import 'bloc/inventory_bloc.dart';
import 'model/earthquake_victims_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.red
      ..backgroundColor = Colors.white
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<INetworkRepository>(
          create: (context) => FirebaseRepository(FirebaseDatabase.instance),
        ),
        RepositoryProvider<FirebaseAuthRepository>(
          create: (context) => FirebaseAuthRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            lazy: false,
            create: (context) => AuthenticationBloc(
              context.read<FirebaseAuthRepository>(),
              context.read<INetworkRepository>(),
            )..add(AuthenticationInitialEvent()),
          ),
          BlocProvider(
              create: (context) => EathquakeBloc(
                    context.read<INetworkRepository>(),
                  ))
        ],
        child: MaterialApp(
          title: 'Yardım Takip',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          initialRoute: '/sign_in',
          onGenerateRoute: (settings) {
            if (settings.name == '/inventory') {
              final earthquakeVictims = settings.arguments as EarthquakeVictims;
              return MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => InventoryBloc(
                    context.read<INetworkRepository>(),
                    context.read<FirebaseAuthRepository>(),
                  ),
                  child: EntryInventoryScreen(
                    earthquakeVictims: earthquakeVictims,
                  ),
                ),
              );
            } else if (settings.name == '/earthquake_victims_detail') {
              final earthquakeVictims = settings.arguments as EarthquakeVictims;
              return MaterialPageRoute(
                builder: (context) => EarthquakeVictimsDetailScreen(
                  earthquakeVictims: earthquakeVictims,
                ),
              );
            }
            return null;
          },
          routes: {
            '/home': (context) => const HomeScreen(),
            '/sign_in': (context) => const LoginScreen(),
            '/sign_up': (context) => const RegisterScreen(),
            '/user_info': (context) => const UserInfoView(),
            '/profile': (context) => const UserProfileScreen(),
            '/conditions': (context) => const ConditionsScreen(),
          },
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
