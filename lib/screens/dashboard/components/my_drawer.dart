// import 'package:automated_clinic_management_system/services/auth_service.dart';
import 'package:automated_clinic_management_system/core/services/drawer_service.dart';
import 'package:automated_clinic_management_system/providers/drawer_provider.dart';
import 'package:automated_clinic_management_system/core/utils/constants.dart';
import 'package:automated_clinic_management_system/core/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});
  final DrawerService drawerService = DrawerService();
  // final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Consumer<DrawerProvider>(
      builder: (context, drawerProvider, child) {
        // Show loading indicator while fetching user data
        if (drawerProvider.isLoading) {
          return const Drawer(
            child: Center(child: CircularProgressIndicator()), // Loading screen
          );
        }

        // If there's an error message, show a SnackBar
        if (drawerProvider.errorMessage.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(drawerProvider.errorMessage)),
            );
          });
        }

        return Drawer(
          child: Column(
            children: [
              // **Drawer Header (User Avatar, Email, Full Name)**
              SizedBox(
                height: 200,
                child: UserAccountsDrawerHeader(
                  accountEmail: Text(
                    drawerProvider.adminEmail,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  accountName: Text(
                    drawerProvider.adminFullName,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  currentAccountPictureSize: const Size(100, 100),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: AppConstants.priColor,
                    child: Text(
                      drawerProvider.adminInitials,
                      style: const TextStyle(fontSize: 45, color: Colors.white),
                    ),
                  ),
                ),
              ),

              // **Sidebar Items**
              Expanded(
                child: ListView(
                  children: [
                    _buildDrawerItem(Icons.dashboard, "Dashboard",
                        AppRoutes.dashboard, context),
                    _buildExpansionTile(
                      Icons.person,
                      "Patient Management",
                      [
                        _buildDrawerItem(Icons.person_add, "New Patient",
                            '/registerPatient', context),
                        _buildDrawerItem(Icons.list, "View Patients",
                            '/viewPatients', context),
                      ],
                      context, // Passing context here
                    ),
                    _buildExpansionTile(
                      Icons.medical_services,
                      "Consultations & Treatments",
                      [
                        _buildDrawerItem(Icons.add, "New Consultation",
                            '/newConsultation', context),
                        _buildDrawerItem(Icons.visibility, "View Consultations",
                            '/viewConsultations', context),
                      ],
                      context, // Passing context here
                    ),
                    _buildExpansionTile(
                      Icons.inventory,
                      "Drug & Inventory",
                      [
                        _buildDrawerItem(
                            Icons.add_box, "Add New Drug", '/addDrug', context),
                        _buildDrawerItem(
                            Icons.store, "View Stock", '/viewStock', context),
                      ],
                      context, // Passing context here
                    ),
                    _buildDrawerItem(Icons.notifications,
                        "Notifications & Alerts", '/notifications', context),
                    _buildDrawerItem(Icons.bar_chart, "Reports & Analytics",
                        '/reports', context),
                    _buildDrawerItem(Icons.settings, "Settings",
                        AppRoutes.settings, context),
                  ],
                ),
              ),

              // **Logout Button**
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  "Logout",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  // Call the logout method
                  await FirebaseAuth.instance.signOut(); // Firebase sign out
                  // Optionally reset the user data in the provider
                  Provider.of<DrawerProvider>(context, listen: false)
                      .setUserData('', '', '', '');
                  // Navigate to login screen
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // **Build Drawer Item**: A function to build each list item in the sidebar
  Widget _buildDrawerItem(
      IconData icon, String title, String route, BuildContext context) {
    // Get the current route
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      textColor: currentRoute == route
          ? Colors.blue
          : null, // Change text color for active route
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }

  // **Build Expansion Tile**: A function to build each expandable section in the sidebar
  Widget _buildExpansionTile(IconData icon, String title, List<Widget> children,
      BuildContext context) {
    // Get the current route
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return ExpansionTile(
      leading: Icon(icon),
      title: Text(title),
      textColor: currentRoute == title
          ? Colors.blue.shade100
          : null, // Highlight active expansion tile
      childrenPadding: const EdgeInsets.only(left: 20),
      children: children,
    );
  }
}
