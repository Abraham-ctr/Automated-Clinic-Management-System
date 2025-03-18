// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:automated_clinic_management_system/screens/auth/login_admin_screen.dart';
// import 'package:automated_clinic_management_system/screens/dashboard/dashboard_screen.dart';

// class AuthProvider with ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   User? _user;
//   bool _isLoading = false;

//   User? get user => _user;
//   bool get isLoading => _isLoading;

//   Future<void> register({
//   required String surname,
//   required String firstName,
//   required String middleName,
//   required String email,
//   required String phone,
//   required String regNumber,
//   required String password,
//   required String gender,
//   required BuildContext context,
// }) async {
//   _isLoading = true;
//   notifyListeners();

//   try {
//     // Function to capitalize first letter
//     String formatName(String name) {
//       return name.trim().isEmpty
//           ? ""
//           : name.trim()[0].toUpperCase() + name.trim().substring(1).toLowerCase();
//     }

//     // Format names
//     surname = formatName(surname);
//     firstName = formatName(firstName);
//     middleName = formatName(middleName);
//     gender = formatName(gender);

//     // Validate phone number
//     phone = phone.trim();
//     if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Phone number must contain only digits.")),
//       );
//       return;
//     }
//     if (phone.length > 15) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Phone number cannot exceed 15 digits.")),
//       );
//       return;
//     }

//     // Create user with Firebase Auth
//     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//       email: email.trim(),
//       password: password.trim(),
//     );
//     _user = userCredential.user;

//     // Save user data to Firestore
//     await _firestore.collection("admins").doc(_user!.uid).set({
//       "surname": surname,
//       "firstName": firstName,
//       "middleName": middleName,
//       "email": email.trim(),
//       "phone": phone,
//       "regNumber": regNumber.trim(),
//       "gender": gender,
//       "createdAt": Timestamp.now(),
//     });

//     // Show success message
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Registration successful!")),
//     );

//     // Navigate to login screen
//     if (context.mounted) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginAdminScreen()),
//       );
//     }
//   } catch (e) {
//     String errorMessage = "An error occurred. Please try again.";

//     if (e is FirebaseAuthException) {
//       switch (e.code) {
//         case 'email-already-in-use':
//           errorMessage = "This email is already registered.";
//           break;
//         case 'weak-password':
//           errorMessage = "Password is too weak. Use a stronger password.";
//           break;
//         case 'invalid-email':
//           errorMessage = "Invalid email format.";
//           break;
//         default:
//           errorMessage = "Registration failed. Please check your details.";
//           break;
//       }
//     }

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(errorMessage)),
//     );
//   } finally {
//     _isLoading = false;
//     notifyListeners();
//   }
// }


//   // Login User
//   Future<void> login({
//     required String email,
//     required String password,
//     required BuildContext context,
//   }) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email.trim(),
//         password: password.trim(),
//       );
//       _user = userCredential.user;

//       if (context.mounted) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const DashboardScreen()),
//         );
//       }
//     } catch (e) {
//       String errorMessage = "Login failed. Please try again.";

//       if (e is FirebaseAuthException) {
//         switch (e.code) {
//           case 'user-not-found':
//             errorMessage = "No user found with this email.";
//             break;
//           case 'wrong-password':
//             errorMessage = "Incorrect password. Please try again.";
//             break;
//           case 'invalid-email':
//             errorMessage = "Invalid email format.";
//             break;
//           default:
//             errorMessage = "Login failed. Check your credentials.";
//             break;
//         }
//       }

//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(errorMessage)),
//         );
//       }
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   // Logout User
//   Future<void> logout(BuildContext context) async {
//     try {
//       await _auth.signOut();
//       _user = null;
//       notifyListeners();

//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("You have been logged out.")),
//         );
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const LoginAdminScreen()),
//         );
//       }
//     } catch (e) {
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Logout failed. Please try again.")),
//         );
//       }
//     }
//   }

//   // Reset Password
//   Future<void> resetPassword(String email, BuildContext context) async {
//     if (email.isEmpty) {
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Please enter your email address.")),
//         );
//       }
//       return;
//     }

//     try {
//       await _auth.sendPasswordResetEmail(email: email.trim());

//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("A password reset link has been sent to your email.")),
//         );
//         Navigator.pop(context);
//       }
//     } on FirebaseAuthException catch (e) {
//       String errorMessage = "An error occurred. Please try again.";

//       if (e.code == 'user-not-found') {
//         errorMessage = "No user found with this email.";
//       } else if (e.code == 'invalid-email') {
//         errorMessage = "Please enter a valid email address.";
//       }

//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(errorMessage)),
//         );
//       }
//     } catch (e) {
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Something went wrong. Please try again.")),
//         );
//       }
//     }
//   }
// }
