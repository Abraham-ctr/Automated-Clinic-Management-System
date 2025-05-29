import 'package:automated_clinic_management_system/providers/auth_provider.dart'
    as my_auth;
import 'package:automated_clinic_management_system/providers/drawer_provider.dart';
import 'package:automated_clinic_management_system/providers/theme_provider.dart';
import 'package:automated_clinic_management_system/core/services/drawer_service.dart';
import 'package:automated_clinic_management_system/core/utils/routes.dart';
import 'package:automated_clinic_management_system/providers/user_profile_provider.dart';
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
        ChangeNotifierProvider(create: (context) => DrawerProvider()),
        Provider(create: (context) => DrawerService()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => my_auth.AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            // debugShowCheckedModeBanner: false,
            title: 'DOMICARE',
            theme: themeProvider.themeData, // Use the dynamic theme
            initialRoute: '/',
            routes: AppRoutes.getRoutes(),
          );
        },
      ),
    );
  }
}
