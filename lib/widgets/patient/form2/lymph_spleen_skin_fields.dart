import 'package:flutter/material.dart';

class LymphSpleenSkinFields extends StatelessWidget {
  final String? lymphaticGlands;
  final String? spleen;
  final String? skin;
  final void Function(String?) onLymphChanged;
  final void Function(String?) onSpleenChanged;
  final void Function(String?) onSkinChanged;

  const LymphSpleenSkinFields({
    super.key,
    required this.lymphaticGlands,
    required this.spleen,
    required this.skin,
    required this.onLymphChanged,
    required this.onSpleenChanged,
    required this.onSkinChanged,
  });

  @override
  Widget build(BuildContext context) {
    final lymphOptions = ['Not Enlarged', 'Enlarged', 'Tender', 'Abnormal'];
    final spleenOptions = ['Not Palpable', 'Palpable', 'Enlarged', 'Tender', 'Abnormal'];
    final skinOptions = ['Normal', 'Rash', 'Pale', 'Jaundiced', 'Lesions', 'Abnormal'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Lymphatic Glands, Spleen, Skin", style: TextStyle(fontWeight: FontWeight.bold)),

        DropdownButtonFormField<String>(
          value: lymphaticGlands,
          onChanged: onLymphChanged,
          decoration: const InputDecoration(labelText: 'Lymphatic Glands'),
          items: lymphOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          validator: (val) => val == null || val.isEmpty ? 'Select lymphatic condition' : null,
        ),

        const SizedBox(height: 12),

        DropdownButtonFormField<String>(
          value: spleen,
          onChanged: onSpleenChanged,
          decoration: const InputDecoration(labelText: 'Spleen'),
          items: spleenOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          validator: (val) => val == null || val.isEmpty ? 'Select spleen condition' : null,
        ),

        const SizedBox(height: 12),

        DropdownButtonFormField<String>(
          value: skin,
          onChanged: onSkinChanged,
          decoration: const InputDecoration(labelText: 'Skin'),
          items: skinOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          validator: (val) => val == null || val.isEmpty ? 'Select skin condition' : null,
        ),
      ],
    );
  }
}
