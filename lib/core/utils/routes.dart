import 'package:automated_clinic_management_system/models/patient.dart';
import 'package:automated_clinic_management_system/screens/features/inventory_management/add_drug_screen.dart';
import 'package:automated_clinic_management_system/screens/features/inventory_management/drug_list_screen.dart';
import 'package:automated_clinic_management_system/screens/features/patient_management/create_patient/biodata_form_screen.dart';
import 'package:automated_clinic_management_system/screens/features/patient_management/create_patient/medical_test_form_screen.dart';
import 'package:automated_clinic_management_system/screens/features/patient_management/view_patient/view_patient.dart';
import 'package:automated_clinic_management_system/screens/features/settings/components/notifications_screen.dart';
import 'package:automated_clinic_management_system/screens/features/settings/settings_screen.dart';
import 'package:automated_clinic_management_system/screens/landing_screen.dart';
import 'package:automated_clinic_management_system/screens/dashboard/dashboard_screen.dart';
import 'package:automated_clinic_management_system/screens/auth/forgot_password_screen.dart';
import 'package:automated_clinic_management_system/screens/auth/login_admin_screen.dart';
import 'package:automated_clinic_management_system/screens/auth/register_admin_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String landing = '/';
  // auth
  static const String register = '/register';
  static const String login = '/login';
  static const String forgotPassword = '/forgotPassword';
  // dashboard
  static const String dashboard = '/dashboard';

  // patient
  static const String biodata = '/biodata';
  static const String medicalTest = '/medicalTest';
  static const String viewPatients = '/viewPatients';

  // drug
  static const String addDrug = '/addDrug';
  static const String viewDrug = '/viewDrug';

  static const String setting = '/settings';
  static const String notifications = '/notifications';

  // Route generator with proper argument handling
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landing:
        return MaterialPageRoute(builder: (_) => const LandingScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterAdminScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginAdminScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case biodata:
        return MaterialPageRoute(builder: (_) => const BiodataFormScreen());
      case medicalTest:
        final biodata = settings.arguments as PatientBiodata;
        return MaterialPageRoute(
          builder: (_) => MedicalTestFormScreen(biodata: biodata),
        );
      case viewPatients:
        return MaterialPageRoute(builder: (_) => const ViewPatientsScreen());
      case addDrug:
        return MaterialPageRoute(builder: (_) => const AddDrugScreen());
      case viewDrug:
        return MaterialPageRoute(builder: (_) => const DrugListScreen());
      case setting:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
