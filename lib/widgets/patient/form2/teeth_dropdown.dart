import 'package:flutter/material.dart';

class TeethDropdown extends StatelessWidget {
  final String? value;
  final Function(String) onChanged;

  const TeethDropdown({
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
          labelText: 'Teeth',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        items: const [
          DropdownMenuItem(value: 'Healthy', child: Text('Healthy')),
          DropdownMenuItem(value: 'Decayed', child: Text('Decayed')),
          DropdownMenuItem(value: 'Missing', child: Text('Missing')),
          DropdownMenuItem(value: 'Dirty', child: Text('Dirty')),
          DropdownMenuItem(value: 'Abnormal', child: Text('Abnormal')),
        ],
        onChanged: (val) {
          if (val != null) onChanged(val);
        },
      ),
    );
  }
}
