import 'package:flutter/material.dart';

class SpinalReflexDropdown extends StatelessWidget {
  final String? value;
  final Function(String) onChanged;

  const SpinalReflexDropdown({
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
          labelText: 'Spinal Reflex',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        items: const [
          DropdownMenuItem(value: 'Normal', child: Text('Normal')),
          DropdownMenuItem(
              value: 'Hyperreflexia', child: Text('Hyperreflexia')),
          DropdownMenuItem(value: 'Hyporeflexia', child: Text('Hyporeflexia')),
          DropdownMenuItem(value: 'Absent', child: Text('Absent')),
          DropdownMenuItem(value: 'Not Tested', child: Text('Not Tested')),
        ],
        onChanged: (val) {
          if (val != null) onChanged(val);
        },
      ),
    );
  }
}
