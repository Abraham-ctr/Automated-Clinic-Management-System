import 'package:flutter/material.dart';

class MaritalStatusDropdown extends StatelessWidget {
  final Function(String) onChanged;
  const MaritalStatusDropdown({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Marital Status',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        items: const [
          DropdownMenuItem(value: 'Single', child: Text('Single')),
          DropdownMenuItem(value: 'Married', child: Text('Married')),
          DropdownMenuItem(value: 'Divorced', child: Text('Divorced')),
          DropdownMenuItem(value: 'Widowed', child: Text('Widowed')),
        ],
        onChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
      ),
    );
  }
}
