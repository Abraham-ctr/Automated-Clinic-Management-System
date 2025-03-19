import 'package:automated_clinic_management_system/providers/drawer_provider.dart';
import 'package:automated_clinic_management_system/providers/theme_provider.dart';
import 'package:automated_clinic_management_system/services/drawer_service.dart';
import 'package:automated_clinic_management_system/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DrawerProvider()),
        Provider(create: (context) => DrawerService()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Clinic Management System',
            theme: themeProvider.themeData, // Use the dynamic theme
            initialRoute: '/',
            routes: AppRoutes.getRoutes(),
          );
        },
      ),
    );
  }
}
