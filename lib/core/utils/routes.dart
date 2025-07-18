import 'package:automated_clinic_management_system/models/consultation_model.dart';
import 'package:automated_clinic_management_system/models/patient.dart';
import 'package:automated_clinic_management_system/screens/features/consultation_management/consultation_list_screen.dart';
import 'package:automated_clinic_management_system/screens/features/consultation_management/edit_consultation_screen.dart';
import 'package:automated_clinic_management_system/screens/features/consultation_management/new_consultaion.dart';
import 'package:automated_clinic_management_system/screens/features/inventory_management/add_drug_screen.dart';
import 'package:automated_clinic_management_system/screens/features/inventory_management/drug_list_screen.dart';
import 'package:automated_clinic_management_system/screens/features/patient_management/create_patient/biodata_form_screen.dart';
import 'package:automated_clinic_management_system/screens/features/patient_management/create_patient/med_test_form_screen.dart';
import 'package:automated_clinic_management_system/screens/features/patient_management/create_patient/medical_test_form_screen.dart';
import 'package:automated_clinic_management_system/screens/features/patient_management/view_patient/patient_detail_screen.dart';
import 'package:automated_clinic_management_system/screens/features/patient_management/view_patient/view_patient.dart';
import 'package:automated_clinic_management_system/screens/features/notifications/drug_alerts_page.dart';
import 'package:automated_clinic_management_system/screens/features/reports/reports_analytics_page.dart';
import 'package:automated_clinic_management_system/screens/features/settings/settings_screen.dart';
import 'package:automated_clinic_management_system/screens/landing_screen.dart';
import 'package:automated_clinic_management_system/screens/dashboard/dashboard_screen.dart';
import 'package:automated_clinic_management_system/screens/auth/forgot_password_screen.dart';
import 'package:automated_clinic_management_system/screens/auth/login_admin_screen.dart';
import 'package:automated_clinic_management_system/screens/auth/register_admin_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  // landing
  static const String landing = '/';

  // auth
  static const String register = '/register';
  static const String login = '/login';
  static const String forgotPassword = '/forgotPassword';

  // dashboard
  static const String dashboard = '/dashboard';

  // patients
  static const String biodata = '/biodata';
  static const String medicalTest = '/medicalTest';
  static const String medTest = '/medTest';
  static const String viewPatients = '/viewPatients';
  static const String patientDetails = '/patientDetails';

  // consultations
  static const String newConsultation = '/newConsultation';
  static const String viewConsult = '/viewConsult';
  static const String editConsult = '/editConsult';

  // drugs
  static const String addDrug = '/addDrug';
  static const String viewDrug = '/viewDrug';

  // notifications & alerts
  static const String notifications = '/notifications';

  // reports & analytics
  static const String reports = '/reports';

  // settings
  static const String setting = '/settings';

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
        final args = settings.arguments;
        if (args is PatientBiodata) {
          return MaterialPageRoute(
            builder: (_) => MedicalTestFormScreen(biodata: args),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(
                child: Text(
                    'Error: Patient biodata is required for Medical Test screen.'),
              ),
            ),
          );
        }
      case viewPatients:
        return MaterialPageRoute(builder: (_) => const ViewPatientsScreen());
      case patientDetails:
        final args = settings.arguments;
        if (args is Patient) {
          return MaterialPageRoute(
            builder: (_) => PatientDetailScreen(patient: args),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(
                child: Text(
                    'Error: Patient data is required for Patient Details screen.'),
              ),
            ),
          );
        }
      // consultation
      case newConsultation:
        return MaterialPageRoute(builder: (_) => const NewConsultationScreen());
      case viewConsult:
        return MaterialPageRoute(builder: (_) => ConsultationListScreen());
      case editConsult:
        final args = settings.arguments;
        if (args is Consultation) {
          return MaterialPageRoute(
            builder: (_) => EditConsultationScreen(consultation: args),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(
                child:
                    Text('Error: Consultation data is required for editing.'),
              ),
            ),
          );
        }

      // drugs
      case addDrug:
        return MaterialPageRoute(builder: (_) => const AddDrugScreen());
      case viewDrug:
        return MaterialPageRoute(builder: (_) => const DrugListScreen());

      // non functional req
      case reports:
        return MaterialPageRoute(builder: (_) => const DrugReportsPage());
      case setting:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case notifications:
        return MaterialPageRoute(builder: (_) => const DrugAlertsPage());

      case medTest:
        return MaterialPageRoute(builder: (_) => const MedTestFormScreen());

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
