import 'package:automated_clinic_management_system/core/providers/auth_provider.dart'
    as my_auth;
import 'package:automated_clinic_management_system/core/providers/drawer_provider.dart';
import 'package:automated_clinic_management_system/core/providers/drug_provider.dart';
import 'package:automated_clinic_management_system/core/providers/theme_provider.dart';
import 'package:automated_clinic_management_system/core/services/drawer_service.dart';
import 'package:automated_clinic_management_system/core/utils/routes.dart';
import 'package:automated_clinic_management_system/core/providers/user_profile_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => DrawerService()),
        ChangeNotifierProvider(create: (_) => DrawerProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => my_auth.AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
        ChangeNotifierProvider(create: (_) => DrugProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'DOMICARE',
            theme: themeProvider.themeData,

            // Use onGenerateRoute instead of routes:
            onGenerateRoute: AppRoutes.generateRoute,
            initialRoute: AppRoutes.newConsultation,
          );
        },
      ),
    );
  }
}
