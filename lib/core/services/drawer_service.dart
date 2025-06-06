import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:automated_clinic_management_system/core/providers/drawer_provider.dart';

class DrawerService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchUserData(BuildContext context) async {
    final user = _auth.currentUser;

    if (user == null) return;

    try {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists && context.mounted) {
        final data = userDoc.data();

        if (data != null) {
          final firstName = data['firstName'] ?? '';
          final middleName = data['middleName'] ?? '';
          final surname = data['surname'] ?? '';
          final email = data['email'] ?? '';

          Provider.of<DrawerProvider>(context, listen: false)
              .setUserData(firstName, middleName, surname, email);
        } else {
          Provider.of<DrawerProvider>(context, listen: false)
              .setError('User data is empty.');
        }
      } else if (context.mounted) {
        Provider.of<DrawerProvider>(context, listen: false)
            .setError('User document does not exist.');
      }
    } catch (e) {
      if (context.mounted) {
        Provider.of<DrawerProvider>(context, listen: false)
            .setError("Error fetching user data: $e");
      }
    }
  }
}
