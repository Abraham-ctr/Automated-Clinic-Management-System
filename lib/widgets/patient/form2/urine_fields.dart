import 'package:flutter/material.dart';

class UrineFields extends StatelessWidget {
  final String? albumin;
  final String? sugar;
  final String? protein;
  final void Function(String?) onAlbuminChanged;
  final void Function(String?) onSugarChanged;
  final void Function(String?) onProteinChanged;

  const UrineFields({
    super.key,
    required this.albumin,
    required this.sugar,
    required this.protein,
    required this.onAlbuminChanged,
    required this.onSugarChanged,
    required this.onProteinChanged,
  });

  @override
  Widget build(BuildContext context) {
    final options = ['Negative', 'Trace', '+1', '+2', '+3', '+4', 'Not Done'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Urine Test Results",
            style: TextStyle(fontWeight: FontWeight.bold)),
        DropdownButtonFormField<String>(
          value: albumin,
          onChanged: onAlbuminChanged,
          decoration: const InputDecoration(labelText: 'Urine Albumin'),
          items: options
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          validator: (val) =>
              val == null || val.isEmpty ? 'Select albumin result' : null,
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: sugar,
          onChanged: onSugarChanged,
          decoration: const InputDecoration(labelText: 'Urine Sugar'),
          items: options
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          validator: (val) =>
              val == null || val.isEmpty ? 'Select sugar result' : null,
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: protein,
          onChanged: onProteinChanged,
          decoration: const InputDecoration(labelText: 'Urine Protein'),
          items: options
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          validator: (val) =>
              val == null || val.isEmpty ? 'Select protein result' : null,
        ),
      ],
    );
  }
}
