import 'package:flutter/material.dart';
import 'package:automated_clinic_management_system/models/user_model.dart';
import 'package:automated_clinic_management_system/core/services/auth_service.dart';

class UserProfileProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  bool _hasError = false;
  UserModel? _user;

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get firstName => _user?.firstName ?? '';
  String get role => _user?.role ?? '';
  String get regNumber => _user?.regNumber ?? '';

  Future<void> fetchUserData() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      _user = await _authService.getCurrentUser();
      if (_user == null) throw Exception("No user found");
    } catch (_) {
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
