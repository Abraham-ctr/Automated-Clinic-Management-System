import 'package:flutter/material.dart';

class HearingDropdown extends StatelessWidget {
  final Function(String) onChanged;
  final String label;

  const HearingDropdown({
    super.key,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          items: const [
            DropdownMenuItem(value: "Normal", child: Text("Normal")),
            DropdownMenuItem(value: "Impaired", child: Text("Impaired")),
            DropdownMenuItem(value: "Daef", child: Text("Deaf"))
          ],
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          }),
    );
  }
}


// normal impaired deaf