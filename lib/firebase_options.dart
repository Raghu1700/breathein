import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you need to add your Firebase configuration.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        // TODO: Replace with your Android configuration
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you need to add your Firebase configuration.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you need to add your Firebase configuration.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you need to add your Firebase configuration.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you need to add your Firebase configuration.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR-API-KEY',
    appId: 'YOUR-APP-ID',
    messagingSenderId: 'YOUR-SENDER-ID',
    projectId: 'YOUR-PROJECT-ID',
    storageBucket: 'YOUR-STORAGE-BUCKET',
  );
}
