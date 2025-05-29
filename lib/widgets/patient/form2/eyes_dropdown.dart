import 'package:flutter/material.dart';

class EyesDropdown extends StatelessWidget {
  final String? value;
  final Function(String) onChanged;

  const EyesDropdown({
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
          labelText: 'Eyes',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        items: const [
          DropdownMenuItem(value: 'Normal', child: Text('Normal')),
          DropdownMenuItem(value: 'Redness', child: Text('Redness')),
          DropdownMenuItem(value: 'Jaundice', child: Text('Jaundice')),
          DropdownMenuItem(value: 'Discharge', child: Text('Discharge')),
          DropdownMenuItem(value: 'Abnormal', child: Text('Abnormal')),
        ],
        onChanged: (val) {
          if (val != null) onChanged(val);
        },
      ),
    );
  }
}
