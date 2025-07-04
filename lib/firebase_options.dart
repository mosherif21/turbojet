// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart'
    show Firebase, FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

Future<void> initializeFireBaseApp() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

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
    apiKey: 'AIzaSyDlSZ_5SS41UUr5zuhNuDN3T-CXUY5bt20',
    appId: '1:87102759065:web:b7d188d837f1d5a3921808',
    messagingSenderId: '87102759065',
    projectId: 'turbojetenginepro',
    authDomain: 'turbojetenginepro.firebaseapp.com',
    storageBucket: 'turbojetenginepro.firebasestorage.app',
    measurementId: 'G-3KNHHEFCBL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBGaU253osbyXd6y3VsBFnOBbL28gkRKM4',
    appId: '1:87102759065:android:2cbf3e943b0485d3921808',
    messagingSenderId: '87102759065',
    projectId: 'turbojetenginepro',
    storageBucket: 'turbojetenginepro.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA14vyuoH6-eGiwufkLpxtdQocph7tWXbs',
    appId: '1:87102759065:ios:1e5995862cf25d70921808',
    messagingSenderId: '87102759065',
    projectId: 'turbojetenginepro',
    storageBucket: 'turbojetenginepro.firebasestorage.app',
    iosClientId:
        '87102759065-77dtgmkrpgj1er36k3modnhp80a657bt.apps.googleusercontent.com',
    iosBundleId: 'com.example.turboJet',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA14vyuoH6-eGiwufkLpxtdQocph7tWXbs',
    appId: '1:87102759065:ios:1e5995862cf25d70921808',
    messagingSenderId: '87102759065',
    projectId: 'turbojetenginepro',
    storageBucket: 'turbojetenginepro.firebasestorage.app',
    iosClientId:
        '87102759065-77dtgmkrpgj1er36k3modnhp80a657bt.apps.googleusercontent.com',
    iosBundleId: 'com.example.turboJet',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDlSZ_5SS41UUr5zuhNuDN3T-CXUY5bt20',
    appId: '1:87102759065:web:8db666cf73eaf3a4921808',
    messagingSenderId: '87102759065',
    projectId: 'turbojetenginepro',
    authDomain: 'turbojetenginepro.firebaseapp.com',
    storageBucket: 'turbojetenginepro.firebasestorage.app',
    measurementId: 'G-JZ42CN3HDS',
  );
}
