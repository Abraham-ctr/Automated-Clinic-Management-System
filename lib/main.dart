import 'package:automated_clinic_management_system/providers/drawer_provider.dart';
import 'package:automated_clinic_management_system/services/drawer_service.dart';
import 'package:automated_clinic_management_system/utils/constants.dart';
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clinic Management System',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: AppConstants.bgColor,
        ),
        
        initialRoute: '/',
        routes: AppRoutes.getRoutes(),

      ),
    );
  }
}
