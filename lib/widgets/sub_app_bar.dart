import 'package:flutter/material.dart';

class SubAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String text;
   const SubAppBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      title:  Text(
        text,
        style: const TextStyle(
          color: Color(0XFFae9719),
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
