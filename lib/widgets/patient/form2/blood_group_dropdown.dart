import 'package:flutter/material.dart';

class BloodGroupDropdown extends StatelessWidget {
  final String? value;
  final Function(String) onChanged;

  const BloodGroupDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const options = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: 'Blood Group',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (val) {
          if (val != null) onChanged(val);
        },
        validator: (val) => val == null || val.isEmpty ? 'Select blood group' : null,
      ),
    );
  }
}
