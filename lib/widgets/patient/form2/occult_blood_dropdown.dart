import 'package:flutter/material.dart';

class OccultBloodDropdown extends StatelessWidget {
  final String? value;
  final Function(String) onChanged;

  const OccultBloodDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const options = [
      'Negative',
      'Positive',
      'Seen',
      'Not Seen',
      'Normal',
      'Abnormal',
      'Not Done',
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: 'Occult Blood',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (val) {
          if (val != null) onChanged(val);
        },
      ),
    );
  }
}
