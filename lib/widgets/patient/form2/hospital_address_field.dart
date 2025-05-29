import 'package:flutter/material.dart';

class HospitalAddressField extends StatelessWidget {
  final String? value;
  final Function(String) onChanged;

  const HospitalAddressField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      maxLines: 2,
      decoration: InputDecoration(
        labelText: 'Hospital Address',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onChanged: onChanged,
      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
    );
  }
}
