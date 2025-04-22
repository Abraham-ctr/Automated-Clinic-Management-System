import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    throw UnsupportedError('platform not supported');
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyCo8v8qOBHFBs2WJq9puSURZcskEKPOt7k",
    authDomain: "acms-b4b83.firebaseapp.com",
    projectId: "acms-b4b83",
    storageBucket: "acms-b4b83.firebasestorage.app",
    messagingSenderId: "781779922553",
    appId: "1:781779922553:web:3ead1352c0b5b5af7b6ea8"
  );

}
