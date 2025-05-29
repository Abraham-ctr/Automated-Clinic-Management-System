import 'package:flutter/material.dart';

class PapillaryReflexDropdown extends StatelessWidget {
  final String? value;
  final Function(String) onChanged;

  const PapillaryReflexDropdown({
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
          labelText: 'Papillary Reflex',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        items: const [
          DropdownMenuItem(value: 'Normal', child: Text('Normal')),
          DropdownMenuItem(value: 'Absent', child: Text('Absent')),
          DropdownMenuItem(value: 'Sluggish', child: Text('Sluggish')),
          DropdownMenuItem(value: 'Brisk', child: Text('Brisk')),
          DropdownMenuItem(value: 'Not Tested', child: Text('Not Tested')),
        ],
        onChanged: (val) {
          if (val != null) onChanged(val);
        },
      ),
    );
  }
}
