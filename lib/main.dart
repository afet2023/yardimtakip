import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yardimtakip/firebase_options.dart';
import 'package:yardimtakip/repository/network_repository.dart';
import 'package:yardimtakip/screens/home/home_screen.dart';

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
        providers: [],
        child: MaterialApp(
          title: 'Yardım Takip',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          initialRoute: '/select_volunteer',
          routes: {
            '/home': (context) => const HomeScreen(),
          },
        ),
      ),
    );
  }
}
