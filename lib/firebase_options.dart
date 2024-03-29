// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDlVj7etJUnzjls-6Wni79BtVMwJnpKpTQ',
    appId: '1:149823858651:web:b2f899f8b5d45bcc2ee9fe',
    messagingSenderId: '149823858651',
    projectId: 'afet2023',
    authDomain: 'afet2023.firebaseapp.com',
    storageBucket: 'afet2023.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMU1MqVJePKb3DDclVA-w2eTI8WxnOoBc',
    appId: '1:149823858651:android:6e6b0d2404e197bf2ee9fe',
    messagingSenderId: '149823858651',
    projectId: 'afet2023',
    storageBucket: 'afet2023.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBV2m1JIvXcvSsNxW4Yo2wp-prpS0g6vrI',
    appId: '1:149823858651:ios:2376ec1354fe942b2ee9fe',
    messagingSenderId: '149823858651',
    projectId: 'afet2023',
    storageBucket: 'afet2023.appspot.com',
    iosClientId: '149823858651-s6gs7ipqa4eff0g3kpb31nsv508updbm.apps.googleusercontent.com',
    iosBundleId: 'org.afet2023.yardimtakip',
  );
}
