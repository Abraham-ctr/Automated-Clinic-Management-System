import 'package:flutter/material.dart';

class GenotypeDropdown extends StatelessWidget {
  final String? value;
  final Function(String) onChanged;

  const GenotypeDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const options = ['AA', 'AS', 'SS', 'AC', 'SC'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: 'Genotype',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (val) {
          if (val != null) onChanged(val);
        },
        validator: (val) => val == null || val.isEmpty ? 'Select genotype' : null,
      ),
    );
  }
}
