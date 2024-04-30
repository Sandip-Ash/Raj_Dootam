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
    apiKey: 'AIzaSyDP8vw7hvscwqDtqJByE_SSnzHdIaHE230',
    appId: '1:569761403456:web:9e0dcf2347912a490c05a5',
    messagingSenderId: '569761403456',
    projectId: 'raj-dootam',
    authDomain: 'raj-dootam.firebaseapp.com',
    storageBucket: 'raj-dootam.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDKAiXncmPYVqzAr9jarVx58-xu-ybsf3w',
    appId: '1:569761403456:android:f8fcd32f499e48430c05a5',
    messagingSenderId: '569761403456',
    projectId: 'raj-dootam',
    storageBucket: 'raj-dootam.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBjDWw2Xv0eC-cBBGLuVeeHtKCl-x2dE-4',
    appId: '1:569761403456:ios:a0a244012ce97d310c05a5',
    messagingSenderId: '569761403456',
    projectId: 'raj-dootam',
    storageBucket: 'raj-dootam.appspot.com',
    iosBundleId: 'com.example.rajDootam',
  );
}
