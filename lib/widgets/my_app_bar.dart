import 'package:automated_clinic_management_system/services/auth_service.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({super.key});
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey.shade100,
      title: const Text(
        "Dominion University Clinic Management System",
        style: TextStyle(
          color: Color(0XFFae9719),
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      toolbarHeight: 80,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.black), // Drawer menu button
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
              authService.logoutUser(context: context);
            },
            icon: const Icon(Icons.logout, color: Colors.red),
            tooltip: "Logout",
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
