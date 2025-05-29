import 'package:flutter/material.dart';

class SkinDropdown extends StatelessWidget {
  final String? value;
  final Function(String) onChanged;

  const SkinDropdown({
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
          labelText: 'Skin',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        items: const [
          DropdownMenuItem(value: 'Normal', child: Text('Normal')),
          DropdownMenuItem(value: 'Rash', child: Text('Rash')),
          DropdownMenuItem(value: 'Pale', child: Text('Pale')),
          DropdownMenuItem(value: 'Jaundiced', child: Text('Jaundiced')),
          DropdownMenuItem(value: 'Lesions', child: Text('Lesions')),
          DropdownMenuItem(value: 'Abnormal', child: Text('Abnormal')),
        ],
        onChanged: (val) {
          if (val != null) onChanged(val);
        },
      ),
    );
  }
}
