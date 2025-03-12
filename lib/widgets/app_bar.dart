import 'package:automated_clinic_management_system/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "Dominion University Clinic Management System",
        style: TextStyle(
          color: Color(0XFFae9719),
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: (){
              Provider.of<AuthProvider>(context, listen: false).logout(context);
            },
            icon: const Icon(Icons.logout, color: Colors.red,),
            tooltip: "Logout",
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
