import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: "AIzaSyDyfzFgQocdHJz-fm5tuHa2h1hA6SbhKTA",
      authDomain: "automated-clinic-management.firebaseapp.com",
      projectId: "automated-clinic-management",
      storageBucket: "automated-clinic-management.firebasestorage.app",
      messagingSenderId: "67711085107",
      appId: "1:67711085107:web:f3fb3b25bb4e031c2a1146",
      measurementId: "G-7RRWVCZ08Y",
    );
  }
}