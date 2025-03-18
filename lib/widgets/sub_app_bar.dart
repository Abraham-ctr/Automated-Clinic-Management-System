import 'package:flutter/material.dart';

class SubAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String text;
   const SubAppBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey.shade100,
      title:  Text(
        text,
        style: const TextStyle(
          color: Color(0XFFae9719),
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.black), // Drawer menu button
          onPressed: () {
            Scaffold.of(context).openDrawer(); // Correctly finds the Scaffold
          },
        ),
      ),
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
