import 'package:automated_clinic_management_system/screens/dashboard/components/date_time_display.dart';
import 'package:automated_clinic_management_system/screens/dashboard/components/welcome_text.dart';
import 'package:automated_clinic_management_system/services/drawer_service.dart';
import 'package:automated_clinic_management_system/widgets/feature_card.dart';
import 'package:automated_clinic_management_system/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:automated_clinic_management_system/widgets/my_app_bar.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  
  final ValueNotifier<String?> _flippedCardNotifier = ValueNotifier(null);

  @override
  void dispose() {
    _flippedCardNotifier.dispose(); // Dispose to prevent memory leaks
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Fetch user data as soon as the DashboardScreen is loaded
    Provider.of<DrawerService>(context, listen: false).fetchUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: Column(
        children: [
          // Custom App Bar
          MyAppBar(),
          
          const SizedBox(height: 10),
          // Welcome Text
          const WelcomeText(),

          // Feature Cards
          Expanded(
            child: Center(
              child: Wrap(
                spacing: MediaQuery.of(context).size.width * 0.02, // Adaptive spacing
                runSpacing: 20, // Vertical spacing
                alignment: WrapAlignment.center,
                children: [
                  FeatureCard(
                    title: "Patients",
                    icon: Icons.person,
                    color: Colors.blue,
                    flippedCardNotifier: _flippedCardNotifier,
                    onTap: () {
                      Navigator.pushNamed(context, '/patientManagement');
                    },
                  ),
                  FeatureCard(
                    title: "Consultations",
                    icon: Icons.medical_services,
                    color: Colors.green,
                    flippedCardNotifier: _flippedCardNotifier,
                    onTap: () {
                      Navigator.pushNamed(context, '/consultations');
                    },
                  ),
                  FeatureCard(
                    title: "Drugs & Inventory",
                    icon: Icons.inventory,
                    color: Colors.purple,
                    flippedCardNotifier: _flippedCardNotifier,
                    onTap: () {
                      Navigator.pushNamed(context, '/inventory');
                    },
                  ),
                  FeatureCard(
                    title: "Reports & Analytics",
                    icon: Icons.bar_chart,
                    color: Colors.orange,
                    flippedCardNotifier: _flippedCardNotifier,
                    onTap: () {
                      Navigator.pushNamed(context, '/reports');
                    },
                  ),
                  FeatureCard(
                    title: "Notifications",
                    icon: Icons.notifications,
                    color: Colors.red,
                    flippedCardNotifier: _flippedCardNotifier,
                    onTap: () {
                      Navigator.pushNamed(context, '/notifications');
                    },
                  ),
                ],
              ),
            ),
          ),

          const DateTimeDisplay(),
          const SizedBox(height: 10,)
        ],
      ),
    );
  }
}
