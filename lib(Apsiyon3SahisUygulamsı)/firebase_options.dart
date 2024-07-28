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
    apiKey: 'AIzaSyA_ADF_KdQj7D-LRmosFtiZ6sTnSbEfxbI',
    appId: '1:353181287831:web:8ff120283734eb9a6bb0d2',
    messagingSenderId: '353181287831',
    projectId: 'apsiyon-hackathon',
    authDomain: 'apsiyon-hackathon.firebaseapp.com',
    storageBucket: 'apsiyon-hackathon.appspot.com',
    measurementId: 'G-BGRPNXGRWK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAeoVzaFk23xak4bk2Fhw3D0OwyXif0bxw',
    appId: '1:353181287831:android:945dd4e4b4d7f5cd6bb0d2',
    messagingSenderId: '353181287831',
    projectId: 'apsiyon-hackathon',
    storageBucket: 'apsiyon-hackathon.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC6jJ1FlijhbP8CXTu2HXlfLeRu7jKvcg4',
    appId: '1:353181287831:ios:cf5706da9bee586e6bb0d2',
    messagingSenderId: '353181287831',
    projectId: 'apsiyon-hackathon',
    storageBucket: 'apsiyon-hackathon.appspot.com',
    iosBundleId: 'com.example.apsiyon',
  );
}
