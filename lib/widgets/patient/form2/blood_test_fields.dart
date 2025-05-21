import 'package:flutter/material.dart';

class BloodTestFields extends StatelessWidget {
  final String? bloodHb;
  final String? bloodGroup;
  final String? genotype;
  final String? vdrlTest;

  final void Function(String?) onBloodHbChanged;
  final void Function(String?) onBloodGroupChanged;
  final void Function(String?) onGenotypeChanged;
  final void Function(String?) onVdrlTestChanged;

  const BloodTestFields({
    super.key,
    required this.bloodHb,
    required this.bloodGroup,
    required this.genotype,
    required this.vdrlTest,
    required this.onBloodHbChanged,
    required this.onBloodGroupChanged,
    required this.onGenotypeChanged,
    required this.onVdrlTestChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Blood Tests",
            style: TextStyle(fontWeight: FontWeight.bold)),
        TextFormField(
          initialValue: bloodHb,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Hemoglobin (Hb) Level'),
          onChanged: onBloodHbChanged,
          validator: (val) =>
              val == null || val.isEmpty ? 'Enter hemoglobin level' : null,
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: bloodGroup,
          onChanged: onBloodGroupChanged,
          decoration: const InputDecoration(labelText: 'Blood Group'),
          items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          validator: (val) =>
              val == null || val.isEmpty ? 'Select blood group' : null,
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: genotype,
          onChanged: onGenotypeChanged,
          decoration: const InputDecoration(labelText: 'Genotype'),
          items: ['AA', 'AS', 'SS', 'AC', 'SC']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          validator: (val) =>
              val == null || val.isEmpty ? 'Select genotype' : null,
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: vdrlTest,
          onChanged: onVdrlTestChanged,
          decoration: const InputDecoration(labelText: 'VDRL Test'),
          items: ['Positive', 'Negative', 'Not Done']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          validator: (val) =>
              val == null || val.isEmpty ? 'Select VDRL result' : null,
        ),
      ],
    );
  }
}
