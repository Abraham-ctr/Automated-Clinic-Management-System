import 'package:flutter/material.dart';

class UrineProteinDropdown extends StatelessWidget {
  final String? value;
  final Function(String) onChanged;

  const UrineProteinDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const options = ['Negative', 'Trace', '+1', '+2', '+3', '+4', 'Not Done'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: 'Urine Protein',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        items: options
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (val) {
          if (val != null) onChanged(val);
        },
      ),
    );
  }
}
