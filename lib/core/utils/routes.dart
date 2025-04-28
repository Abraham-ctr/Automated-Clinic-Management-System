import 'package:automated_clinic_management_system/screens/features/patient_management/medical_form_part1.dart';
import 'package:automated_clinic_management_system/screens/features/patient_management/medical_form_part2.dart';
import 'package:automated_clinic_management_system/screens/settings/components/notifications_screen.dart';
import 'package:automated_clinic_management_system/screens/settings/settings_screen.dart';
import 'package:automated_clinic_management_system/screens/landing_screen.dart';
import 'package:automated_clinic_management_system/screens/dashboard/dashboard_screen.dart';
import 'package:automated_clinic_management_system/screens/auth/forgot_password_screen.dart';
import 'package:automated_clinic_management_system/screens/auth/login_admin_screen.dart';
import 'package:automated_clinic_management_system/screens/auth/register_admin_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
static const String landing = '/';
  static const String register = '/register';
  static const String login = '/login';
  static const String forgotPassword = '/forgotPassword';

  static const String dashboard = '/dashboard';
  static const String registerPatient = '/registerPatient';
   static const String registerPatient2 = '/registerPatient2';

  static const String settings = '/settings';
  static const String notifications = '/notifications';
  

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      landing: (context) => const LandingScreen(),
      register: (context) => const RegisterAdminScreen(),
      login: (context) => const LoginAdminScreen(),
      forgotPassword: (context) => const ForgotPasswordScreen(),

      dashboard: (context) => const DashboardScreen(),
      registerPatient: (context) => const MedicalFormPart1(),
      registerPatient2: (context) => const MedicalFormPart2(formData: {},),
      


      settings: (context) => const SettingsScreen(),
      notifications: (context) => const NotificationsScreen(),

    };
  }
}
