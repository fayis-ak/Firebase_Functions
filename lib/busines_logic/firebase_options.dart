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
    apiKey: 'AIzaSyAjFpAFL5jR0J1STW6id_GkDlWrzVIcwNo',
    appId: '1:102065608226:web:de8c8d253980f06a125c7b',
    messagingSenderId: '102065608226',
    projectId: 'fir-fuctions-5a619',
    authDomain: 'fir-fuctions-5a619.firebaseapp.com',
    storageBucket: 'fir-fuctions-5a619.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCfAgyLyTX6pYtfv9YOrqhvpZps9NtJMkA',
    appId: '1:102065608226:android:9dc966361b905696125c7b',
    messagingSenderId: '102065608226',
    projectId: 'fir-fuctions-5a619',
    storageBucket: 'fir-fuctions-5a619.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAEQThqUTQlkJnLbwYxRtI9mbdcTtfYJm4',
    appId: '1:102065608226:ios:a3616b57da1692b4125c7b',
    messagingSenderId: '102065608226',
    projectId: 'fir-fuctions-5a619',
    storageBucket: 'fir-fuctions-5a619.appspot.com',
    iosBundleId: 'com.example.firebaseFuctions',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAEQThqUTQlkJnLbwYxRtI9mbdcTtfYJm4',
    appId: '1:102065608226:ios:600d87a7ba94a28a125c7b',
    messagingSenderId: '102065608226',
    projectId: 'fir-fuctions-5a619',
    storageBucket: 'fir-fuctions-5a619.appspot.com',
    iosBundleId: 'com.example.firebaseFuctions.RunnerTests',
  );
}
