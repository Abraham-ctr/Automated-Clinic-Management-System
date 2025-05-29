import 'package:flutter/material.dart';

class OtherObservationField extends StatelessWidget {
  final String? value;
  final Function(String) onChanged;

  const OtherObservationField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'Other Observation',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onChanged: onChanged,
    );
  }
}
