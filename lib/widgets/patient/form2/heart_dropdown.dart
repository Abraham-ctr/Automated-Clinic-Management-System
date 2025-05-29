import 'package:flutter/material.dart';

class HeartDropdown extends StatelessWidget {
  final String? value;
  final Function(String) onChanged;

  const HeartDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final heartOptions = ['Normal', 'Murmur', 'Irregular', 'Abnormal'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: 'Heart',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        items: heartOptions
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (val) {
          if (val != null) onChanged(val);
        },
        validator: (value) =>
            value == null || value.isEmpty ? 'Select heart condition' : null,
      ),
    );
  }
}
