import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:automated_clinic_management_system/providers/drawer_provider.dart';

class DrawerService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch user data
  Future<void> fetchUserData(BuildContext context) async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          // Extract user data
          String firstName = userDoc['firstName'] ?? '';
          String middleName = userDoc['middleName'] ?? '';
          String surname = userDoc['surname'] ?? '';
          String email = userDoc['email'] ?? '';

          // Use the provider to update user data
          Provider.of<DrawerProvider>(context, listen: false).setUserData(firstName, middleName, surname, email);
        }
      } catch (e) {
        // Directly show error in the context, but no mounted check here
        Provider.of<DrawerProvider>(context, listen: false).setError("Error fetching user data: $e");
      }
    }
  }
}
