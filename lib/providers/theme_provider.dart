import 'package:automated_clinic_management_system/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadTheme(); // Load the theme from storage when the app starts
  }

  // Toggle between dark and light mode
  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isDarkMode", _isDarkMode);
  }

  // Load theme preference from SharedPreferences
  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool("isDarkMode") ?? false;
    notifyListeners();
  }

  // Custom Light and Dark Mode Themes
  ThemeData get themeData => _isDarkMode ? darkTheme : lightTheme;

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppConstants.whiteColor,
    scaffoldBackgroundColor: AppConstants.whiteColor,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[100],
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.grey[900],
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
  );
}
