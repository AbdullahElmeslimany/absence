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
    apiKey: 'AIzaSyBdT2-IHEylvoTLVHD02VBWo4Vr06NwpXw',
    appId: '1:925747815350:web:0d7dfd183694cc77d25717',
    messagingSenderId: '925747815350',
    projectId: 'absence-of-salab',
    authDomain: 'absence-of-salab.firebaseapp.com',
    storageBucket: 'absence-of-salab.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPbBgBr981OmxOMXGrUFtboR8hn0jmHPQ',
    appId: '1:925747815350:android:abd6206f20e605f3d25717',
    messagingSenderId: '925747815350',
    projectId: 'absence-of-salab',
    storageBucket: 'absence-of-salab.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCzZafqnnesqo4Sj9dfOwqWGxd4BRxmIwA',
    appId: '1:925747815350:ios:229d5e285ed064fbd25717',
    messagingSenderId: '925747815350',
    projectId: 'absence-of-salab',
    storageBucket: 'absence-of-salab.appspot.com',
    iosBundleId: 'com.DevMuslim.absence',
  );
}