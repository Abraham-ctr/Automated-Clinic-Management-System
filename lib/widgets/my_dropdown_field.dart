import 'package:automated_clinic_management_system/utils/constants.dart';
import 'package:flutter/material.dart';

class MyDropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const MyDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        dropdownColor: AppConstants.bgColor,
        value: value == "" ? null : value, // Ensure it doesn't select an empty value
        items: [
          DropdownMenuItem<String>( // Disabled default option
            value: null,
            enabled: false,
            child: Text("Select $label", style: const TextStyle(color: Colors.grey)), // Makes it unselectable
          ),
          ...items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 16)),
            );
          }).toList(),
        ],
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        ),
        validator: (value) => (value == null || value.isEmpty) ? "Please select $label" : null,
      ),
    );
  }
}
