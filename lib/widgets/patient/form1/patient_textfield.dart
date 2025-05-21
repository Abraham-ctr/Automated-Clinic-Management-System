import 'package:flutter/material.dart';

class PatientTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isRequired;
  final bool isNumeric;

  const PatientTextfield({
    super.key,
    required this.controller,
    required this.label,
    this.isRequired = false,
    this.isNumeric = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.5),
          ),
          errorStyle: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w500,
          ),
        ),
        validator: (value) {
          if (isRequired && (value == null || value.trim().isEmpty)) {
            return '$label is required';
          }

          if (isNumeric && value != null && value.isNotEmpty) {
            final isValid = double.tryParse(value) != null;
            if (!isValid) return 'Enter a valid number';
          }

          return null;
        },
      ),
    );
  }
}
