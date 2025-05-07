import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:automated_clinic_management_system/models/user_model.dart';

/// Custom exception for auth errors, carrying a user‑friendly message.
class AuthException implements Exception {
  final String message;
  AuthException(this.message);
  @override
  String toString() => message;
}

/// A service class encapsulating all authentication and user‑profile operations,
/// with uniform error handling via AuthException.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String _usersCollection = 'users';

  /// Registers a new user, saves profile in Firestore, or throws AuthException.
  Future<UserModel> register({
    required String email,
    required String password,
    required String surname,
    required String firstName,
    required String middleName,
    required String phoneNumber,
    required String regNumber,
    required String gender,
    required String role,
  }) async {
    try {
      // 1) Create Auth user
      final creds = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 2) Build our user model
      final user = UserModel(
        uid: creds.user!.uid,
        surname: surname,
        firstName: firstName,
        middleName: middleName,
        email: email,
        phoneNumber: phoneNumber,
        regNumber: regNumber,
        gender: gender,
        role: role,
        createdAt: Timestamp.now(),
      );

      // 3) Persist to Firestore
      await _db.collection(_usersCollection).doc(user.uid).set(user.toMap());
      return user;
    } on FirebaseAuthException catch (e) {
      // Relay Firebase’s own messages
      throw AuthException(e.message ?? 'Registration failed');
    } catch (_) {
      // Fallback
      throw AuthException('An unexpected error occurred during registration');
    }
  }

  /// Sends a password‑reset email or throws AuthException.
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Could not send reset email');
    } catch (_) {
      throw AuthException('An unexpected error occurred sending reset email');
    }
  }

  /// Signs in and fetches profile, or throws AuthException.
  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      final creds = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final doc =
          await _db.collection(_usersCollection).doc(creds.user!.uid).get();
      if (!doc.exists) {
        throw AuthException('No profile found for this account');
      }
      return UserModel.fromMap(doc.data()!, doc.id);
    } on FirebaseAuthException catch (e) {
      print(
          "FirebaseAuthException: ${e.message}, Code: ${e.code}"); // Log the Firebase Auth exception
      throw AuthException(e.message ?? 'Login failed');
    } catch (e) {
      print("Unexpected error: $e"); // Log the unexpected error
      throw AuthException('An unexpected error occurred during login');
    }
  }

  /// Signs out, or throws AuthException.
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (_) {
      throw AuthException('Failed to sign out');
    }
  }

  /// Returns the currently signed‑in FirebaseAuth user, or null.
  User? get currentFirebaseUser => _auth.currentUser;

  /// Fetches the current user’s profile, or throws AuthException.
  Future<UserModel?> getCurrentUserProfile() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser == null) return null;

    try {
      final doc =
          await _db.collection(_usersCollection).doc(firebaseUser.uid).get();
      if (!doc.exists) return null;
      return UserModel.fromMap(doc.data()!, doc.id);
    } catch (_) {
      throw AuthException('Failed to fetch user profile');
    }
  }

  /// Stream of FirebaseAuth auth‑state changes.
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
