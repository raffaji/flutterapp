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
    apiKey: 'AIzaSyCLULdRcpbTvMha0iyDUdVUdjwbkF0jX94',
    appId: '1:593408473964:web:2cb031dd722b07ec8c9149',
    messagingSenderId: '593408473964',
    projectId: 'sample-weather-ai-app',
    authDomain: 'sample-weather-ai-app.firebaseapp.com',
    storageBucket: 'sample-weather-ai-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-D7u1IjGB-dm8MAH0F2uEBd1qHbKL-G0',
    appId: '1:593408473964:android:05cbde7e27bd99708c9149',
    messagingSenderId: '593408473964',
    projectId: 'sample-weather-ai-app',
    storageBucket: 'sample-weather-ai-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDxCETS3cXreVt1DfuMvf7b4wiZByqrlfU',
    appId: '1:593408473964:ios:0be404f9ca37f3e38c9149',
    messagingSenderId: '593408473964',
    projectId: 'sample-weather-ai-app',
    storageBucket: 'sample-weather-ai-app.appspot.com',
    iosBundleId: 'com.example.test1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDxCETS3cXreVt1DfuMvf7b4wiZByqrlfU',
    appId: '1:593408473964:ios:0be404f9ca37f3e38c9149',
    messagingSenderId: '593408473964',
    projectId: 'sample-weather-ai-app',
    storageBucket: 'sample-weather-ai-app.appspot.com',
    iosBundleId: 'com.example.test1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCLULdRcpbTvMha0iyDUdVUdjwbkF0jX94',
    appId: '1:593408473964:web:a476f37a15214eed8c9149',
    messagingSenderId: '593408473964',
    projectId: 'sample-weather-ai-app',
    authDomain: 'sample-weather-ai-app.firebaseapp.com',
    storageBucket: 'sample-weather-ai-app.appspot.com',
  );
}