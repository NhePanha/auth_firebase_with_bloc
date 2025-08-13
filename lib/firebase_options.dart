import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
/// Default [FirebaseOptions] for use with your Firebase apps.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD6NdlQt8kBDAjsHT-1bi-dAQ05UPTRYcg',
    appId: '1:263645205630:android:45b46281cef9f571b7342f',
    messagingSenderId: '263645205630',
    projectId: 'test-project-cli-fffa7',
    storageBucket: 'test-project-cli-fffa7.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBQvPmwuU9cIMZ5qlM4mh94fH_QogKXqVE',
    appId: '1:23728065809:ios:8eeba769c04d1132f350b0',
    messagingSenderId: '23728065809',
    projectId: 'fir-store-72037',
    storageBucket: 'fir-store-72037.firebasestorage.app',
    iosBundleId: 'com.example.firebaseAuthEcm',
  );

}