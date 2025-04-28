import 'package:automated_clinic_management_system/core/services/auth_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _role;
  String? _firstName;
  String? _regNumber;
  bool _isLoading = true;
  bool _hasError = false;

  String? get role => _role;
  String? get firstName => _firstName;
  String? get regNumber => _regNumber;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  final AuthService _authService = AuthService(); // Your AuthService

  // Fetch current user data using AuthService
  Future<void> fetchUserData() async {
    try {
      _isLoading = true;
      _hasError = false;
      notifyListeners();

      final userProfile = await _authService.getCurrentUserProfile(); // Use AuthService to get user profile

      if (userProfile != null) {
        _role = userProfile.role;
        _firstName = userProfile.firstName; 
        _regNumber = userProfile.regNumber; 
      } else {
        _hasError = true;
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _hasError = true;
      notifyListeners();
    }
  }
}
