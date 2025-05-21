import 'package:flutter/material.dart';

class LungsTeethLiverFields extends StatelessWidget {
  final String? lungs;
  final String? teeth;
  final String? liver;
  final void Function(String?) onLungsChanged;
  final void Function(String?) onTeethChanged;
  final void Function(String?) onLiverChanged;

  const LungsTeethLiverFields({
    super.key,
    required this.lungs,
    required this.teeth,
    required this.liver,
    required this.onLungsChanged,
    required this.onTeethChanged,
    required this.onLiverChanged,
  });

  @override
  Widget build(BuildContext context) {
    final lungsOptions = ['Normal', 'Rhonchi', 'Crackles', 'Decreased Air Entry', 'Abnormal'];
    final teethOptions = ['Healthy', 'Decayed', 'Missing', 'Dirty', 'Abnormal'];
    final liverOptions = ['Normal', 'Enlarged', 'Tender', 'Not Palpable', 'Abnormal'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Lungs, Teeth, Liver", style: TextStyle(fontWeight: FontWeight.bold)),

        DropdownButtonFormField<String>(
          value: lungs,
          onChanged: onLungsChanged,
          decoration: const InputDecoration(labelText: 'Lungs'),
          items: lungsOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          validator: (val) => val == null || val.isEmpty ? 'Select lungs condition' : null,
        ),

        const SizedBox(height: 12),

        DropdownButtonFormField<String>(
          value: teeth,
          onChanged: onTeethChanged,
          decoration: const InputDecoration(labelText: 'Teeth'),
          items: teethOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          validator: (val) => val == null || val.isEmpty ? 'Select teeth condition' : null,
        ),

        const SizedBox(height: 12),

        DropdownButtonFormField<String>(
          value: liver,
          onChanged: onLiverChanged,
          decoration: const InputDecoration(labelText: 'Liver'),
          items: liverOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          validator: (val) => val == null || val.isEmpty ? 'Select liver condition' : null,
        ),
      ],
    );
  }
}
