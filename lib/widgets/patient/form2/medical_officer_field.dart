import 'package:flutter/material.dart';

class MedicalOfficerField extends StatelessWidget {
  final String? value;
  final Function(String) onChanged;

  const MedicalOfficerField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(
        labelText: 'Medical Officer Name',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onChanged: onChanged,
      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
    );
  }
}
