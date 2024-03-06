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
    apiKey: 'AIzaSyBTtylwxFf84GmjK4CNFe1ATyC9Jg8DpHQ',
    appId: '1:269891100934:web:cbacb0da693fe564317e87',
    messagingSenderId: '269891100934',
    projectId: 'expense-tracker-74858',
    authDomain: 'expense-tracker-74858.firebaseapp.com',
    storageBucket: 'expense-tracker-74858.appspot.com',
    measurementId: 'G-J5GTCY8WHW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDGpMHEvJjkTFedOorMA5qQ3o9djuxLwKY',
    appId: '1:269891100934:android:d70106fc2ded0e42317e87',
    messagingSenderId: '269891100934',
    projectId: 'expense-tracker-74858',
    storageBucket: 'expense-tracker-74858.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCXV7Dw1YTIo-4YFKu1n5I71X1DdkYE-8k',
    appId: '1:269891100934:ios:8b914906adad25be317e87',
    messagingSenderId: '269891100934',
    projectId: 'expense-tracker-74858',
    storageBucket: 'expense-tracker-74858.appspot.com',
    iosBundleId: 'com.example.expenseTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCXV7Dw1YTIo-4YFKu1n5I71X1DdkYE-8k',
    appId: '1:269891100934:ios:efdafa985a3c2336317e87',
    messagingSenderId: '269891100934',
    projectId: 'expense-tracker-74858',
    storageBucket: 'expense-tracker-74858.appspot.com',
    iosBundleId: 'com.example.expenseTracker.RunnerTests',
  );
}