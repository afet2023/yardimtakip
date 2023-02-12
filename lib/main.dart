import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yardimtakip/firebase_options.dart';
import 'package:yardimtakip/repository/network_repository.dart';
import 'package:yardimtakip/screens/conditions/conditions_screen.dart';
import 'package:yardimtakip/screens/home/home_screen.dart';

import 'package:yardimtakip/screens/user_profile/user_profile.screen.dart';


import 'package:yardimtakip/screens/userinfo/userinfo_screen.dart';

import 'bloc/authentication_bloc.dart';

import 'bloc/inventory_bloc.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<INetworkRepository>(
          create: (context) => FirebaseRepository(FirebaseDatabase.instance),
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
            }
            return null;
          },
          routes: {
            '/home': (context) => const HomeScreen(),
            '/sign_in': (context) => const LoginScreen(),
            '/sign_up': (context) => const RegisterScreen(),
            '/user_info': (context) => UserSaveInfo(),
             '/profile': (context) => const UserProfileScreen(),
          '/conditions': (context) => const ConditionsScreen(),
          },
        ),

      ),
    );
  }
}
