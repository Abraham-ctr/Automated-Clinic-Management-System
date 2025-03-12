import 'package:automated_clinic_management_system/providers/auth_provider.dart';
import 'package:automated_clinic_management_system/providers/admin_provider.dart';
import 'package:automated_clinic_management_system/screens/patient_registration_screen.dart';
import 'package:automated_clinic_management_system/screens/view_patients_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<AdminProvider>(context);

    // Function to get name initials
    String getInitials(String? name) {
      if (name == null || name.isEmpty) return "A"; // Default to 'A' for Admin
      List<String> nameParts = name.split(" ");
      String initials = nameParts.map((part) => part.isNotEmpty ? part[0] : "").join().toUpperCase();
      return initials.length > 2 ? initials.substring(0, 2) : initials;
    }

    return Drawer(
      child: Column(
        children: [
          // Drawer Header with Profile Avatar & Name
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0XFFae9719)),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Text(
                      getInitials(adminProvider.firstName),
                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  Text(
                    adminProvider.firstName,
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              children: [
                _buildExpandableTile(
                  title: "Patient Management",
                  icon: Icons.person,
                  children: [
                    _buildSubItem("Register/Create Patient", Icons.person_add, onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PatientRegistrationScreen()),
                      );
                    }),
                    _buildSubItem("View Patient Records", Icons.folder_open, onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewPatientsScreen()), // Add the screen for View Patient Records
                      );
                    }),
                  ],
                ),
                _buildExpandableTile(title: "Consultations & Treatments", icon: Icons.local_hospital),
                _buildExpandableTile(
                  title: "Drug & Inventory Management",
                  icon: Icons.medication,
                  children: [
                    _buildSubItem("Add New Drug", Icons.add),
                    _buildSubItem("View Stock", Icons.inventory),
                  ],
                ),
                _buildExpandableTile(
                  title: "Reports & Analytics",
                  icon: Icons.bar_chart,
                ),
                _buildExpandableTile(title: "Settings", icon: Icons.settings),
                _buildExpandableTile(title: "Notifications & Alerts", icon: Icons.notifications),
                const Divider(), // Adds a separator before logout

                // Logout Button
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text("Logout", style: TextStyle(color: Colors.red)),
                  onTap: () {
                    Provider.of<AuthProvider>(context, listen: false).logout(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to create expandable menu items
  Widget _buildExpandableTile({required String title, required IconData icon, List<Widget>? children}) {
    return ExpansionTile(
      leading: Icon(icon),
      title: Text(title),
      children: children ?? [],
    );
  }

  // Function to create sub-items with optional nested sub-items
  Widget _buildSubItem(String title, IconData icon, {List<Widget>? subItems, VoidCallback? onTap}) {
    if (subItems != null && subItems.isNotEmpty) {
      return ExpansionTile(
        leading: Icon(icon),
        title: Text(title),
        children: subItems,
      );
    }
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap ?? () {},
    );
  }
}
