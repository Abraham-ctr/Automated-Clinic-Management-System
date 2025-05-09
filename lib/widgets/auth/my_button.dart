import 'package:automated_clinic_management_system/core/utils/constants.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
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
            padding: const EdgeInsets.symmetric(vertical: 25),
            backgroundColor: backgroundColor ?? AppConstants.priColor,
            foregroundColor: textColor ?? Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        child: isLoading
        ? const CircularProgressIndicator(
          color: AppConstants.middleGreyColor,
        )
        : Text(text)
      )

      // second button
      : OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 25),
          side: BorderSide(color: borderColor ?? AppConstants.secColor, width: 2),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: isLoading
        ? const CircularProgressIndicator(
          color: AppConstants.middleGreyColor,
        )
        : Text(
          text,
          style: TextStyle( color: textColor ?? AppConstants.secColor ),
        )
      ),
    );
  }
}
