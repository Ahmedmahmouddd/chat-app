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
    apiKey: 'AIzaSyBkRp_IDGFCEDjRKoBfK2acMnwf9uXM5fw',
    appId: '1:836924371491:web:958adb446d8f5008d43796',
    messagingSenderId: '836924371491',
    projectId: 'chat-app-682dc',
    authDomain: 'chat-app-682dc.firebaseapp.com',
    storageBucket: 'chat-app-682dc.appspot.com',
    measurementId: 'G-2R8LS4NYEF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD1kWSbnf5t5CpEkHwxftX9XMXiG30nz5E',
    appId: '1:836924371491:android:861eb3482dba2b23d43796',
    messagingSenderId: '836924371491',
    projectId: 'chat-app-682dc',
    storageBucket: 'chat-app-682dc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC6hpaxsrVJEwufnGUfO90SyQ_C7QzQSwk',
    appId: '1:836924371491:ios:1d8ebc137bc3b306d43796',
    messagingSenderId: '836924371491',
    projectId: 'chat-app-682dc',
    storageBucket: 'chat-app-682dc.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC6hpaxsrVJEwufnGUfO90SyQ_C7QzQSwk',
    appId: '1:836924371491:ios:1d8ebc137bc3b306d43796',
    messagingSenderId: '836924371491',
    projectId: 'chat-app-682dc',
    storageBucket: 'chat-app-682dc.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBkRp_IDGFCEDjRKoBfK2acMnwf9uXM5fw',
    appId: '1:836924371491:web:ee48f98f07476c3dd43796',
    messagingSenderId: '836924371491',
    projectId: 'chat-app-682dc',
    authDomain: 'chat-app-682dc.firebaseapp.com',
    storageBucket: 'chat-app-682dc.appspot.com',
    measurementId: 'G-GQDHQE5EKC',
  );
}
