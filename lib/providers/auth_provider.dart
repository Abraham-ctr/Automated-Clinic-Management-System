import 'package:automated_clinic_management_system/core/services/auth_service.dart';
import 'package:automated_clinic_management_system/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Various phases of our auth flow
enum AuthStatus {
  uninitialized,  // before we know if someone’s logged in
  authenticating, // in the middle of register/login/reset
  authenticated,  // we have a valid user
  unauthenticated,// no user logged in
  error           // last operation failed
}

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;

  AuthStatus _status = AuthStatus.uninitialized;
  UserModel?   _user;
  String?      _errorMessage;

  AuthProvider({AuthService? authService})
      : _authService = authService ?? AuthService() {
    _listenToAuthState();
  }

  // Public getters
  AuthStatus get status       => _status;
  UserModel? get user         => _user;
  String?    get errorMessage => _errorMessage;

  /// Starts listening to FirebaseAuth’s state changes.
  /// When it emits a user, we fetch their profile; otherwise we clear state.
  void _listenToAuthState() {
    _authService.authStateChanges.listen((firebaseUser) async {
      if (firebaseUser == null) {
        _status = AuthStatus.unauthenticated;
        _user   = null;
        notifyListeners();
      } else {
        _status = AuthStatus.authenticating;
        notifyListeners();

        try {
          _user   = await _authService.getCurrentUserProfile();
          _status = AuthStatus.authenticated;
        } catch (e) {
          _status       = AuthStatus.error;
          _errorMessage = e.toString();
        }
        notifyListeners();
      }
    });
  }

  /// Registers a new nurse/doctor. On success, FirebaseAuth stream will fire
  /// and populate `_user`. On error, we capture the message.
  Future<void> register({
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
    _status       = AuthStatus.authenticating;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.register(
        email: email,
        password: password,
        surname: surname,
        firstName: firstName,
        middleName: middleName,
        phoneNumber: phoneNumber,
        regNumber: regNumber,
        gender: gender,
        role: role,
      );
      // FirebaseAuth stream listener will set status to authenticated
    } catch (e) {
      _status       = AuthStatus.error;
      _errorMessage = e is AuthException ? e.message : e.toString();
      notifyListeners();
    }
  }




  /// Logs in an existing user. On success, FirebaseAuth stream fires.
  Future<void> login({
    required String email,
    required String password,
  }) async {
    _status = AuthStatus.authenticating;
    _errorMessage = null;
    notifyListeners();

    try {
      // Attempt login
      final user = await _authService.login(email: email, password: password);

      if (user != null) {
        // If login is successful
        _status = AuthStatus.authenticated;
      } else {
        // In case user is not found (should ideally never happen if login works properly)
        _status = AuthStatus.error;
        _errorMessage = 'Login failed: User not found';
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific exceptions (e.g., invalid email or password)
      _status = AuthStatus.error;
      _errorMessage = e.message ?? 'Login failed: ${e.code}';
    } on Exception catch (e) {
      // Catch general exceptions
      _status = AuthStatus.error;
      _errorMessage = 'An unexpected error occurred during login: ${e.toString()}';
    } catch (e) {
      // Catch all other errors (e.g., network issues)
      _status = AuthStatus.error;
      _errorMessage = 'An unknown error occurred: ${e.toString()}';
    }

    notifyListeners();
  }



  /// Sends a reset‑password email. On error, captures the message.
  Future<void> resetPassword(String email) async {
    _status = AuthStatus.authenticating; // Start authenticating
    _errorMessage = null; // Clear previous error messages
    notifyListeners();

    try {
      // Call the service method to send password reset email
      await _authService.sendPasswordResetEmail(email);
      
      _status = AuthStatus.unauthenticated; // Successful reset
      _errorMessage = "A password reset link has been sent to your email."; // Success message
      notifyListeners();
    } catch (e) {
      _status = AuthStatus.error; // Handle error state
      _errorMessage = e is AuthException ? e.message : e.toString(); // Get error message
      notifyListeners();
    }
  }





  /// Signs out. The authStateChanges listener will handle clearing `_user`.
  Future<void> signOut() async {
    try {
      await _authService.signOut();
      // Stream listener will set status to unauthenticated
    } catch (e) {
      _status       = AuthStatus.error;
      _errorMessage = e is AuthException ? e.message : e.toString();
      notifyListeners();
    }
  }
}
