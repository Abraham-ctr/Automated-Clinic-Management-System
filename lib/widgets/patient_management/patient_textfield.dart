import 'package:flutter/material.dart';

class PatientTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool isRequired;
  final bool isNumeric;
  final bool isYesNo;
  final bool isDate;
  final bool isBloodGroup;
  final bool isGenotype;
  final String? Function(String?)? validator;

  const PatientTextfield({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.isRequired = false,
    this.isNumeric = false,
    this.isYesNo = false,
    this.isDate = false,
    this.isBloodGroup = false,
    this.isGenotype = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : keyboardType,
      textCapitalization: keyboardType == TextInputType.name ? TextCapitalization.words : TextCapitalization.none,
      autocorrect: keyboardType != TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      validator: validator ??
          (value) {
            if (isRequired && (value == null || value.trim().isEmpty)) {
              return "$label is required";
            }
            if (isNumeric && value != null && value.isNotEmpty && !RegExp(r'^\d+(\.\d+)?$').hasMatch(value)) {
              return "$label must be a valid number";
            }
            if (isYesNo && value != null && value.isNotEmpty && !["yes", "no"].contains(value.toLowerCase())) {
              return 'Enter "Yes" or "No" only';
            }
            if (isDate && value != null && value.isNotEmpty && !RegExp(r'^\d{2}-\d{2}-\d{4}$').hasMatch(value)) {
              return "Enter a valid date (DD-MM-YYYY)";
            }
            if (isBloodGroup && value != null && value.isNotEmpty && !RegExp(r'^(A|B|AB|O)[+-]$').hasMatch(value)) {
              return "Enter a valid blood group (e.g., A+, O-, AB+)";
            }
            if (isGenotype && value != null && value.isNotEmpty && !RegExp(r'^(AA|AS|SS|AC|SC)$').hasMatch(value)) {
              return "Enter a valid genotype (e.g., AA, AS, SS)";
            }
            return null;
          },
    );
  }
}
