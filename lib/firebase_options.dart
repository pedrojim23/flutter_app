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
    apiKey: 'AIzaSyBgCihUsS_DJWQ2mTrwQyPp4b1xyAJjJDI',
    appId: '1:81622941769:web:4e887998d364d3caaebf98',
    messagingSenderId: '81622941769',
    projectId: 'login-9bc90',
    authDomain: 'login-9bc90.firebaseapp.com',
    storageBucket: 'login-9bc90.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCxyPmzkjJG2m6tE8DmvRlL3GKKf5L7YT4',
    appId: '1:81622941769:android:4fe947916a93fcf0aebf98',
    messagingSenderId: '81622941769',
    projectId: 'login-9bc90',
    storageBucket: 'login-9bc90.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAslAlUmRh7AMh6Y4mezHSIyi57IRVa9rM',
    appId: '1:81622941769:ios:65b685d4023443ffaebf98',
    messagingSenderId: '81622941769',
    projectId: 'login-9bc90',
    storageBucket: 'login-9bc90.appspot.com',
    iosBundleId: 'com.example.login',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAslAlUmRh7AMh6Y4mezHSIyi57IRVa9rM',
    appId: '1:81622941769:ios:710de31ff92f5ac3aebf98',
    messagingSenderId: '81622941769',
    projectId: 'login-9bc90',
    storageBucket: 'login-9bc90.appspot.com',
    iosBundleId: 'com.example.login.RunnerTests',
  );
}
