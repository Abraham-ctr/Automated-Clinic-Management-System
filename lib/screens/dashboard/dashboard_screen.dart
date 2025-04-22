import 'package:automated_clinic_management_system/screens/dashboard/components/date_time_display.dart';
import 'package:automated_clinic_management_system/screens/dashboard/components/my_carousel.dart';
import 'package:automated_clinic_management_system/screens/dashboard/components/welcome_text.dart';
import 'package:automated_clinic_management_system/core/services/drawer_service.dart';
import 'package:automated_clinic_management_system/core/utils/constants.dart';
import 'package:automated_clinic_management_system/widgets/feature_card.dart';
import 'package:automated_clinic_management_system/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Image.asset(AppConstants.logo, width: 70,),

            // header title
            const Row(
              children: [
               Text(
                  "Domi",
                  style: TextStyle(
                    color: AppConstants.priColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Care",
                  style: TextStyle(
                    color: AppConstants.secColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  " - The Dominion University Clinic App",
                  style: TextStyle(
                    color: AppConstants.priColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            
          ],
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu), // Drawer menu button
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        // logout button
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                
              },
              icon: const Icon(Icons.logout, color: Colors.red),
              tooltip: "Logout",
            ),
          ),
        ],
      ),

      drawer: MyDrawer(),

      body: SingleChildScrollView(
        child: Column(
          children: [
            
            // Welcome Text
            const WelcomeText(),
        
            // carousel
            const MyCarousel(),

            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: AppConstants.secColor,
                      thickness: 2,
                      endIndent: 10,
                    )
                  ),
                  Text (
                    "Quick Features",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.middleGreyColor,
                    )
                  ),
                  Expanded(
                    child: Divider(
                      color: AppConstants.secColor,
                      thickness: 2,
                      indent: 10,
                    )
                  )
                ]
              ),
            ),

            const SizedBox(height: 10),
            // Feature Cards
            SizedBox(
              child: Expanded(
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
            ),

            

            const SizedBox(height: 10),
            const DateTimeDisplay(),
            const SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
