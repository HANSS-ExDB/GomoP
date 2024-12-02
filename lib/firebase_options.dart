// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyAYugugVKoA-LWLBLsK33cOAjN9tj6yOX8',
    appId: '1:953543068067:web:08fe5dc2b39d92a3973216',
    messagingSenderId: '953543068067',
    projectId: 'gomo-test-5d68d',
    authDomain: 'gomo-test-5d68d.firebaseapp.com',
    storageBucket: 'gomo-test-5d68d.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBB7SC8NjmqPcz1LHvtlkP8BrO7l7lfKjA',
    appId: '1:953543068067:android:e797cd99bc98124c973216',
    messagingSenderId: '953543068067',
    projectId: 'gomo-test-5d68d',
    storageBucket: 'gomo-test-5d68d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBNqVutLn8nNOuJwQOUGZvmDWrD_TkTOiM',
    appId: '1:953543068067:ios:02404bb9ef481f37973216',
    messagingSenderId: '953543068067',
    projectId: 'gomo-test-5d68d',
    storageBucket: 'gomo-test-5d68d.firebasestorage.app',
    iosBundleId: 'com.example.GomoP',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBNqVutLn8nNOuJwQOUGZvmDWrD_TkTOiM',
    appId: '1:953543068067:ios:02404bb9ef481f37973216',
    messagingSenderId: '953543068067',
    projectId: 'gomo-test-5d68d',
    storageBucket: 'gomo-test-5d68d.firebasestorage.app',
    iosBundleId: 'com.example.GomoP',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAYugugVKoA-LWLBLsK33cOAjN9tj6yOX8',
    appId: '1:953543068067:web:986ccad14144a99e973216',
    messagingSenderId: '953543068067',
    projectId: 'gomo-test-5d68d',
    authDomain: 'gomo-test-5d68d.firebaseapp.com',
    storageBucket: 'gomo-test-5d68d.firebasestorage.app',
  );

}