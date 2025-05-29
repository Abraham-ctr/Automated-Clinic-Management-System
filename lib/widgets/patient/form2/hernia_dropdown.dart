import 'package:flutter/material.dart';

class HerniaDropdown extends StatelessWidget {
  final String? value;
  final Function(String) onChanged;

  const HerniaDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: 'Hernia',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        items: const [
          DropdownMenuItem(value: 'No Hernia', child: Text('No Hernia')),
          DropdownMenuItem(value: 'Inguinal Hernia', child: Text('Inguinal Hernia')),
          DropdownMenuItem(value: 'Umbilical Hernia', child: Text('Umbilical Hernia')),
          DropdownMenuItem(value: 'Abdominal Hernia', child: Text('Abdominal Hernia')),
          DropdownMenuItem(value: 'Not Assessed', child: Text('Not Assessed')),
          DropdownMenuItem(value: 'Other', child: Text('Other')),
        ],
        onChanged: (val) {
          if (val != null) onChanged(val);
        },
      ),
    );
  }
}
