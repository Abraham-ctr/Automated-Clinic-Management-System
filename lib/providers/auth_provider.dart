import 'package:automated_clinic_management_system/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum AuthStatus { initial, success, error }

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;
  String? _error;
  User? _user;
  UserModel? _userModel;
  AuthStatus _status = AuthStatus.initial;
  String? _errorMessage;

  // GETTERS
  bool get isLoading => _isLoading;
  String? get error => _error;
  User? get user => _user;
  UserModel? get userModel => _userModel;
  AuthStatus get status => _status;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> registerUser({
    required String surname,
    required String firstName,
    required String middleName,
    required String email,
    required String phoneNumber,
    required String regNumber,
    required String role,
    required String gender,
    required String password,
  }) async {
    _setLoading(true);
    try {
      // Create user in Firebase Auth
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user model
      final userModel = UserModel(
        uid: cred.user!.uid,
        surname: surname,
        firstName: firstName,
        middleName: middleName,
        email: email,
        phoneNumber: phoneNumber,
        regNumber: regNumber,
        role: role,
        createdAt: Timestamp.now(),
        gender: gender,
      );

      // Save to Firestore
      await _firestore
          .collection('users')
          .doc(cred.user!.uid)
          .set(userModel.toMap());

      // Save user to provider
      _user = cred.user;
      _userModel = userModel;
    } on FirebaseAuthException catch (e) {
      _error = e.message ?? 'An unknown error occurred.';
      rethrow; // Important: rethrow so UI can show it
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _error = null;

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;

      if (_user != null) {
        _userModel = await _fetchUserData(_user!.uid);
      }
    } on FirebaseAuthException catch (e) {
      _error = e.message ?? 'Login failed';
      _user = null;
      _userModel = null;
    } catch (e) {
      _error = 'An unexpected error occurred';
      _user = null;
      _userModel = null;
    } finally {
      _setLoading(false);
    }
  }

  Future<UserModel?> _fetchUserData(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!, uid);
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    _setLoading(true);
    _errorMessage = null;
    _status = AuthStatus.initial;
    notifyListeners();

    try {
      await _auth.sendPasswordResetEmail(email: email);
      _status = AuthStatus.success;
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
      _status = AuthStatus.error;
    } catch (e) {
      _errorMessage = 'An unexpected error occurred';
      _status = AuthStatus.error;
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }
}
