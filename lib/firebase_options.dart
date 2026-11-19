import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyB5I3KOkKb2tAv4JyuqP7prXE4beHFG2YQ',
    appId: '1:369168465830:web:3797f5197a67c28e81d967',
    messagingSenderId: '369168465830',
    projectId: 'wastepickupscheduler',
    authDomain: 'wastepickupscheduler.firebaseapp.com',
    storageBucket: 'wastepickupscheduler.firebasestorage.app',
    measurementId: 'G-ZWXKTBBZD6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB1phq9xO6lnU_CqtGhkftltlD0M-hE8sQ',
    appId: '1:369168465830:android:4a5cf3c9b09fa86581d967',
    messagingSenderId: '369168465830',
    projectId: 'wastepickupscheduler',
    storageBucket: 'wastepickupscheduler.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCGBHtff7bJqnRhcd9Fl6mIiLWfTIa5naA',
    appId: '1:369168465830:ios:16573dac3260fa8181d967',
    messagingSenderId: '369168465830',
    projectId: 'wastepickupscheduler',
    storageBucket: 'wastepickupscheduler.firebasestorage.app',
    iosBundleId: 'com.example.wastepickup',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCGBHtff7bJqnRhcd9Fl6mIiLWfTIa5naA',
    appId: '1:369168465830:ios:16573dac3260fa8181d967',
    messagingSenderId: '369168465830',
    projectId: 'wastepickupscheduler',
    storageBucket: 'wastepickupscheduler.firebasestorage.app',
    iosBundleId: 'com.example.wastepickup',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB5I3KOkKb2tAv4JyuqP7prXE4beHFG2YQ',
    appId: '1:369168465830:web:408bbacca2cb61d181d967',
    messagingSenderId: '369168465830',
    projectId: 'wastepickupscheduler',
    authDomain: 'wastepickupscheduler.firebaseapp.com',
    storageBucket: 'wastepickupscheduler.firebasestorage.app',
    measurementId: 'G-VBEEM40HK4',
  );
}
