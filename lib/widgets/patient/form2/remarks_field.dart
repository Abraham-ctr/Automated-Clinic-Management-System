import 'package:flutter/material.dart';

class RemarksField extends StatelessWidget {
  final String? value;
  final Function(String) onChanged;

  const RemarksField({
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
        labelText: 'Remarks',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onChanged: onChanged,
    );
  }
}
