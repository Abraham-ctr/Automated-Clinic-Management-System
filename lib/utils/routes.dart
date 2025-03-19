import 'package:automated_clinic_management_system/screens/settings/settings_screen.dart';
import 'package:automated_clinic_management_system/screens/landing_screen.dart';
import 'package:automated_clinic_management_system/screens/dashboard/dashboard_screen.dart';
import 'package:automated_clinic_management_system/screens/auth/forgot_password_screen.dart';
import 'package:automated_clinic_management_system/screens/auth/login_admin_screen.dart';
import 'package:automated_clinic_management_system/screens/auth/register_admin_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
static const String landing = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String dashboard = '/dashboard';
  static const String forgotPassword = '/forgotPassword';
  static const String settings = '/settings';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      landing: (context) => const LandingScreen(),
      login: (context) => const LoginAdminScreen(),
      register: (context) => const RegisterAdminScreen(),
      dashboard: (context) => const DashboardScreen(),
      forgotPassword: (context) => const ForgotPasswordScreen(),
      settings: (context) => SettingsScreen(),

    };
  }
}
