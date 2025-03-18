import 'package:automated_clinic_management_system/utils/constants.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isPrimary,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: isPrimary
      ? ElevatedButton(
        onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 18),
            backgroundColor: backgroundColor ?? AppConstants.blueColor,
            foregroundColor: textColor ?? Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        child: isLoading
        ? const CircularProgressIndicator()
        : Text(text)
      )
      : OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          side: BorderSide(color: borderColor ?? AppConstants.goldColor, width: 2),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: isLoading
        ? const CircularProgressIndicator()
        : Text(
          text,
          style: TextStyle( color: textColor ?? AppConstants.blueColor ),
        )
      ),
    );
  }
}
