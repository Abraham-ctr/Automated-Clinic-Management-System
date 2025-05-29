import 'package:flutter/material.dart';

class LymphaticDropdown extends StatelessWidget {
  final String? value;
  final Function(String) onChanged;

  const LymphaticDropdown({
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
          labelText: 'Lymphatic Glands',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        items: const [
          DropdownMenuItem(value: 'Not Enlarged', child: Text('Not Enlarged')),
          DropdownMenuItem(value: 'Enlarged', child: Text('Enlarged')),
          DropdownMenuItem(value: 'Tender', child: Text('Tender')),
          DropdownMenuItem(value: 'Abnormal', child: Text('Abnormal')),
        ],
        onChanged: (val) {
          if (val != null) onChanged(val);
        },
      ),
    );
  }
}
