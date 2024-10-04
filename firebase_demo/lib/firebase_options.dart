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
    apiKey: 'AIzaSyDThMoBZ0l8OJ6k8YvSKMDJbZu9nLunHLw',
    appId: '1:880688854607:web:bc0736977ed62b60285c3a',
    messagingSenderId: '880688854607',
    projectId: 'fir-flutter-codelab-708ac',
    authDomain: 'fir-flutter-codelab-708ac.firebaseapp.com',
    storageBucket: 'fir-flutter-codelab-708ac.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDBHNkf2BXeWaqXdW7lU5_4htIiQ7HxLHc',
    appId: '1:880688854607:android:52e66c70287b20f3285c3a',
    messagingSenderId: '880688854607',
    projectId: 'fir-flutter-codelab-708ac',
    storageBucket: 'fir-flutter-codelab-708ac.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvwtXupTN2n953LyXUxiECrEOCgRXdwIk',
    appId: '1:880688854607:ios:cc5afa6ea27f835c285c3a',
    messagingSenderId: '880688854607',
    projectId: 'fir-flutter-codelab-708ac',
    storageBucket: 'fir-flutter-codelab-708ac.appspot.com',
    iosBundleId: 'com.example.firebaseDemo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDvwtXupTN2n953LyXUxiECrEOCgRXdwIk',
    appId: '1:880688854607:ios:cc5afa6ea27f835c285c3a',
    messagingSenderId: '880688854607',
    projectId: 'fir-flutter-codelab-708ac',
    storageBucket: 'fir-flutter-codelab-708ac.appspot.com',
    iosBundleId: 'com.example.firebaseDemo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDThMoBZ0l8OJ6k8YvSKMDJbZu9nLunHLw',
    appId: '1:880688854607:web:366bda4c9de601bd285c3a',
    messagingSenderId: '880688854607',
    projectId: 'fir-flutter-codelab-708ac',
    authDomain: 'fir-flutter-codelab-708ac.firebaseapp.com',
    storageBucket: 'fir-flutter-codelab-708ac.appspot.com',
  );

}