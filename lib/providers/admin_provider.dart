import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminProvider with ChangeNotifier {
  String _firstName = "";
  String _regNumber = "";

  String get firstName => _firstName;
  String get regNumber => _regNumber;

  Future<void> fetchAdminDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection("admins").doc(user.uid).get();

      if (doc.exists) {
        _firstName = doc["firstName"] ?? "";
        _regNumber = doc["regNumber"] ?? "";
        notifyListeners();
      }
    }
  }
}
