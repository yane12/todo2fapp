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
    apiKey: 'AIzaSyDRqSxaLTYBL9s0lvJsU8gFwpTbZ0nV6s4',
    appId: '1:544497011391:web:b07c83a3624df604aa140a',
    messagingSenderId: '544497011391',
    projectId: 'todoapp-b6287',
    authDomain: 'todoapp-b6287.firebaseapp.com',
    storageBucket: 'todoapp-b6287.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDt2W3Y3h3JKpE15Z7WcgrSSTyBaqfhHmw',
    appId: '1:544497011391:android:42f281756624e88faa140a',
    messagingSenderId: '544497011391',
    projectId: 'todoapp-b6287',
    storageBucket: 'todoapp-b6287.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyADB5aIlA4KHylxnwhcYf0yx-chzxnJFgQ',
    appId: '1:544497011391:ios:22e309d28383d78baa140a',
    messagingSenderId: '544497011391',
    projectId: 'todoapp-b6287',
    storageBucket: 'todoapp-b6287.appspot.com',
    iosBundleId: 'com.example.todoapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyADB5aIlA4KHylxnwhcYf0yx-chzxnJFgQ',
    appId: '1:544497011391:ios:22e309d28383d78baa140a',
    messagingSenderId: '544497011391',
    projectId: 'todoapp-b6287',
    storageBucket: 'todoapp-b6287.appspot.com',
    iosBundleId: 'com.example.todoapp',
  );
}
