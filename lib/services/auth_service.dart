import 'package:automated_clinic_management_system/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register User
  Future<void> registerUser({
    required BuildContext context,
    required String surname,
    required String firstName,
    required String middleName,
    required String email,
    required String phoneNumber,
    required String regNumber,
    required String gender,
    required String role,
    required String password,
  }) async {
    try {
      // Create user in Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      // Generate UID from Firebase Auth (using the authenticated user's UID)
      String uid = userCredential.user?.uid ?? '';

      if (uid.isEmpty) {
        throw Exception("Failed to generate UID for user.");
      }

      // Create user model
      UserModel newUser = UserModel(
        uid: uid,
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

      // Save user to Firestore
      await _firestore.collection('users').doc(uid).set(newUser.toMap());

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registration Successful!")));

      // Navigate to the login screen
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }

  // Login User
  Future<void> loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      // Attempting to login with Firebase Authentication
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // If login is successful, show a success message and navigate
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Successful!")));

      // Navigate to the dashboard screen
      Navigator.pushReplacementNamed(context, AppRoutes.dashboard);

    } catch (e) {
      String errorMessage = "Login Error: An unknown error occurred.";

      // Check if it's a FirebaseAuthException
      if (e is FirebaseAuthException) {
        // Handle specific error codes
        switch (e.code) {
          case 'user-not-found':
            errorMessage = "No user found for that email.";
            break;
          case 'wrong-password':
            errorMessage = "Incorrect password provided for that user.";
            break;
          case 'invalid-email':
            errorMessage = "The email address is not valid.";
            break;
          case 'user-disabled':
            errorMessage = "This user has been disabled.";
            break;
          default:
            errorMessage = "Login failed. Please try again.";
        }
      } else {
        // If it's not a FirebaseAuthException, use a generic message
        errorMessage = "An unexpected error occurred.";
      }

      // Show the error message in the SnackBar
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  // Logout User
  Future<void> logoutUser({
    required BuildContext context,
  }) async {
    try {
      await _auth.signOut();

      // Check if the widget is still mounted before showing the SnackBar
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Logged out successfully!")),
      );

      // navigate to login screen after logging out
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    } catch (e) {
      // Handle errors
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logout Error: ${e.toString()}")),
      );
    }
  }

  // Reset Password
  Future<void> resetPassword({
    required BuildContext context,
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password reset link sent to your email!")),
      );

      // Navigate to the login screen
      Navigator.pushReplacementNamed(context, AppRoutes.login);

    } catch (e) {
      String errorMessage = "An error occurred while trying to send the reset link.";
      
      // Handle specific error codes from Firebase
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            errorMessage = "No user found with that email address.";
            break;
          case 'invalid-email':
            errorMessage = "The email address is invalid.";
            break;
          default:
            errorMessage = "An error occurred, please try again later.";
        }
      }
      
      // Show error message in the SnackBar
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  // Get user data from Firestore
  Future<Map<String, dynamic>?> getUserData(BuildContext context) async {
    try {
      User? user = _auth.currentUser; // Get the currently logged-in user
      if (user != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          return userDoc.data() as Map<String, dynamic>;
        } else {
          _showError(context, "User not found in Firestore");
          return null; // User not found in Firestore
        }
      } else {
        _showError(context, "No user is currently logged in");
        return null; // No user logged in
      }
    } catch (e) {
      _showError(context, "Error fetching user data: ${e.toString()}");
      return null; // Return null if there is any error
    }
  }

  // Show error messages using SnackBar
  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
