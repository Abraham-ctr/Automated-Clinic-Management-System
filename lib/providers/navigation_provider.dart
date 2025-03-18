import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  String _currentScreen = 'Dashboard';

  String get currentScreen => _currentScreen;

  void navigateTo(String screen) {
    _currentScreen = screen;
    notifyListeners();
  }
}