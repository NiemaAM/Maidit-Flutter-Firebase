// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members, depend_on_referenced_packages
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
    apiKey: 'AIzaSyA2992pQ7Mp5vU42U_Rc-LVbEgUjR-v4KI',
    appId: '1:113456789664:web:eae36124a059a15f78b1c5',
    messagingSenderId: '113456789664',
    projectId: 'maidit-309d7',
    authDomain: 'maidit-309d7.firebaseapp.com',
    storageBucket: 'maidit-309d7.appspot.com',
    measurementId: 'G-ZGB4PMM4KS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBeIk9iNBwZcGW7kWeuZU05Gg99EWjJOXM',
    appId: '1:113456789664:android:edb1c6fd77e95ff478b1c5',
    messagingSenderId: '113456789664',
    projectId: 'maidit-309d7',
    storageBucket: 'maidit-309d7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDIDVpJJPXYO50CkFth4JdTokEb8FvqCmo',
    appId: '1:113456789664:ios:cf579f7b35fdfa8278b1c5',
    messagingSenderId: '113456789664',
    projectId: 'maidit-309d7',
    storageBucket: 'maidit-309d7.appspot.com',
    iosClientId:
        '113456789664-6cqv2ftkpqo43880mq58r45sgivkhhb8.apps.googleusercontent.com',
    iosBundleId: 'com.example.maidit',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDIDVpJJPXYO50CkFth4JdTokEb8FvqCmo',
    appId: '1:113456789664:ios:cf579f7b35fdfa8278b1c5',
    messagingSenderId: '113456789664',
    projectId: 'maidit-309d7',
    storageBucket: 'maidit-309d7.appspot.com',
    iosClientId:
        '113456789664-6cqv2ftkpqo43880mq58r45sgivkhhb8.apps.googleusercontent.com',
    iosBundleId: 'com.example.maidit',
  );
}
