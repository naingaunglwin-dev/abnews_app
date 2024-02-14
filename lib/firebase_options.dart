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
    apiKey: 'AIzaSyCEb7S2A61lqaFB5S3NrmxHAsotLNs1Mug',
    appId: '1:585107341394:web:9569e0881f4b8470ed5f8b',
    messagingSenderId: '585107341394',
    projectId: 'ab-news-317b0',
    authDomain: 'ab-news-317b0.firebaseapp.com',
    storageBucket: 'ab-news-317b0.appspot.com',
    measurementId: 'G-19XL0W4LPN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCRZs9jJv4PbhtT-uOXjJpquoZeTJEwJaw',
    appId: '1:585107341394:android:ce8255ea6b5c24abed5f8b',
    messagingSenderId: '585107341394',
    projectId: 'ab-news-317b0',
    storageBucket: 'ab-news-317b0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCRtkdtZBP7IkLDwGLc0aN5rVVTmXfdLJU',
    appId: '1:585107341394:ios:d7375474845ac31aed5f8b',
    messagingSenderId: '585107341394',
    projectId: 'ab-news-317b0',
    storageBucket: 'ab-news-317b0.appspot.com',
    iosBundleId: 'com.example.abnews',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCRtkdtZBP7IkLDwGLc0aN5rVVTmXfdLJU',
    appId: '1:585107341394:ios:5afb7b1ac8ad0d2fed5f8b',
    messagingSenderId: '585107341394',
    projectId: 'ab-news-317b0',
    storageBucket: 'ab-news-317b0.appspot.com',
    iosBundleId: 'com.example.abnews.RunnerTests',
  );
}