import 'package:flutter/material.dart';

enum SnackbarType { success, error }

void showSnackBar(BuildContext context, String message, {SnackbarType type = SnackbarType.error}) {
  final color = type == SnackbarType.success ? Colors.green : Colors.redAccent;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
    ),
  );
}
