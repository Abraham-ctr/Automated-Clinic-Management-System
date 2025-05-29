import 'package:flutter/material.dart';

class LungsDropdown extends StatelessWidget {
  final String? value;
  final Function(String) onChanged;

  const LungsDropdown({
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
          labelText: 'Lungs',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        items: const [
          DropdownMenuItem(value: 'Normal', child: Text('Normal')),
          DropdownMenuItem(value: 'Rhonchi', child: Text('Rhonchi')),
          DropdownMenuItem(value: 'Crackles', child: Text('Crackles')),
          DropdownMenuItem(value: 'Decreased Air Entry', child: Text('Decreased Air Entry')),
          DropdownMenuItem(value: 'Abnormal', child: Text('Abnormal')),
        ],
        onChanged: (val) {
          if (val != null) onChanged(val);
        },
      ),
    );
  }
}
