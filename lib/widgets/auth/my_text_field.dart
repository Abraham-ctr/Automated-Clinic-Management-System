import 'package:automated_clinic_management_system/core/utils/constants.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool isRequired;
  final String? Function(String?)? validator;

  const MyTextField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.isRequired = false,
    this.validator,
  });

  @override
  MyTextFieldState createState() => MyTextFieldState();
}

class MyTextFieldState extends State<MyTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textCapitalization: widget.keyboardType == TextInputType.name ? TextCapitalization.words : TextCapitalization.none,
        autocorrect: widget.keyboardType != TextInputType.emailAddress, 
        obscureText: widget.isPassword ? _obscureText : false,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: const TextStyle(color: AppConstants.darkGreyColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                )
              : null,
        ),
        validator: widget.validator ??
            (value) {
              if (widget.isRequired && (value == null || value.trim().isEmpty)) {
                return "${widget.label} is required";
              }
              return null;
            },
      ),
    );
  }
}
