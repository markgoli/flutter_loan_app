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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyAJASstBMrf_goFrtZFh7TEEKiTNt2206c',
    appId: '1:5340469727:web:93546e2fd73e304a358c6a',
    messagingSenderId: '5340469727',
    projectId: 'lmloan',
    authDomain: 'lmloan.firebaseapp.com',
    storageBucket: 'lmloan.appspot.com',
    measurementId: 'G-YD460WQM1J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBdrZ40hfzJiLlEkwJUeQ2H3-Zj_njAzPs',
    appId: '1:5340469727:android:92f41588445524d4358c6a',
    messagingSenderId: '5340469727',
    projectId: 'lmloan',
    storageBucket: 'lmloan.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBnl4z8yU6D8d5ZwIJfqqciO2zKN62v4lo',
    appId: '1:5340469727:ios:375181dcde875fe0358c6a',
    messagingSenderId: '5340469727',
    projectId: 'lmloan',
    storageBucket: 'lmloan.appspot.com',
    iosBundleId: 'com.example.lmloan',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBnl4z8yU6D8d5ZwIJfqqciO2zKN62v4lo',
    appId: '1:5340469727:ios:375181dcde875fe0358c6a',
    messagingSenderId: '5340469727',
    projectId: 'lmloan',
    storageBucket: 'lmloan.appspot.com',
    iosBundleId: 'com.example.lmloan',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAJASstBMrf_goFrtZFh7TEEKiTNt2206c',
    appId: '1:5340469727:web:29597087f189e10f358c6a',
    messagingSenderId: '5340469727',
    projectId: 'lmloan',
    authDomain: 'lmloan.firebaseapp.com',
    storageBucket: 'lmloan.appspot.com',
    measurementId: 'G-3SVPKF7MM1',
  );

}