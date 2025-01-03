// made for firebase and cloud


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
    apiKey: 'AIzaSyBkBMX5sUslGHCAdPjMkvZH13lO9x1PG_4',
    appId: '1:1073709300722:web:b4acf9a59d7d9c68df096b',
    messagingSenderId: '1073709300722',
    projectId: 'tractors24',
    authDomain: 'tractors24.firebaseapp.com',
    storageBucket: 'tractors24.firebasestorage.app',
    measurementId: 'G-BXRJK35VWM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDgRhPd04wtVmdxKkQwJViHI3R_BueSiZ0',
    appId: '1:1073709300722:android:61bc9296696c5e6adf096b',
    messagingSenderId: '1073709300722',
    projectId: 'tractors24',
    storageBucket: 'tractors24.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAvZEuwgQ8TLD-ziLx1V-7LFKfpJmf-hn8',
    appId: '1:1073709300722:ios:6b6002f0ca848149df096b',
    messagingSenderId: '1073709300722',
    projectId: 'tractors24',
    storageBucket: 'tractors24.firebasestorage.app',
    iosBundleId: 'com.example.tractors24',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAvZEuwgQ8TLD-ziLx1V-7LFKfpJmf-hn8',
    appId: '1:1073709300722:ios:6b6002f0ca848149df096b',
    messagingSenderId: '1073709300722',
    projectId: 'tractors24',
    storageBucket: 'tractors24.firebasestorage.app',
    iosBundleId: 'com.example.tractors24',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBkBMX5sUslGHCAdPjMkvZH13lO9x1PG_4',
    appId: '1:1073709300722:web:685eee6521af19bcdf096b',
    messagingSenderId: '1073709300722',
    projectId: 'tractors24',
    authDomain: 'tractors24.firebaseapp.com',
    storageBucket: 'tractors24.firebasestorage.app',
    measurementId: 'G-NVE9Y9HJSW',
  );
}
