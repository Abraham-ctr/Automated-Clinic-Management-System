import 'package:flutter/material.dart';

class DrawerProvider with ChangeNotifier {
  String adminInitials = '';
  String adminFirstName = '';
  String adminEmail = '';
  String adminFullName = '';
  bool isLoading = true;
  String errorMessage = '';

  void setUserData(String firstName, String middleName, String surname, String email) {
    adminFirstName = firstName;
    adminEmail = email;
    adminFullName = "$surname $firstName $middleName";
    adminInitials = (firstName.isNotEmpty ? firstName[0] : '');
    isLoading = false;
    notifyListeners();
  }

  void setError(String error) {
    errorMessage = error;
    isLoading = false;
    notifyListeners();
  }
}
