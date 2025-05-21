import 'package:flutter/material.dart';

class StoolFields extends StatelessWidget {
  final String? occultBlood;
  final String? microscope;
  final String? ovaOrCyst;
  final void Function(String?) onOccultBloodChanged;
  final void Function(String?) onMicroscopeChanged;
  final void Function(String?) onOvaOrCystChanged;

  const StoolFields({
    super.key,
    required this.occultBlood,
    required this.microscope,
    required this.ovaOrCyst,
    required this.onOccultBloodChanged,
    required this.onMicroscopeChanged,
    required this.onOvaOrCystChanged,
  });

  @override
  Widget build(BuildContext context) {
    final options = ['Negative', 'Positive', 'Seen', 'Not Seen', 'Normal', 'Abnormal', 'Not Done'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Stool Examination", style: TextStyle(fontWeight: FontWeight.bold)),

        DropdownButtonFormField<String>(
          value: occultBlood,
          onChanged: onOccultBloodChanged,
          decoration: const InputDecoration(labelText: 'Occult Blood'),
          items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          validator: (val) => val == null || val.isEmpty ? 'Select occult blood result' : null,
        ),

        const SizedBox(height: 12),

        DropdownButtonFormField<String>(
          value: microscope,
          onChanged: onMicroscopeChanged,
          decoration: const InputDecoration(labelText: 'Microscope'),
          items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          validator: (val) => val == null || val.isEmpty ? 'Select microscope result' : null,
        ),

        const SizedBox(height: 12),

        DropdownButtonFormField<String>(
          value: ovaOrCyst,
          onChanged: onOvaOrCystChanged,
          decoration: const InputDecoration(labelText: 'Ova or Cyst'),
          items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          validator: (val) => val == null || val.isEmpty ? 'Select ova/cyst result' : null,
        ),
      ],
    );
  }
}
