import 'package:flutter/material.dart';

class HerniaReflexFields extends StatelessWidget {
  final String? hernia;
  final String? papillaryReflex;
  final String? spinalReflex;
  final void Function(String?) onHerniaChanged;
  final void Function(String?) onPapillaryChanged;
  final void Function(String?) onSpinalChanged;

  const HerniaReflexFields({
    super.key,
    required this.hernia,
    required this.papillaryReflex,
    required this.spinalReflex,
    required this.onHerniaChanged,
    required this.onPapillaryChanged,
    required this.onSpinalChanged,
  });

  @override
  Widget build(BuildContext context) {
    final herniaOptions = [
      'No Hernia',
      'Inguinal Hernia',
      'Umbilical Hernia',
      'Abdominal Hernia',
      'Not Assessed',
      'Other',
    ];
    final papillaryOptions = [
      'Normal',
      'Absent',
      'Sluggish',
      'Brisk',
      'Not Tested'
    ];
    final spinalOptions = [
      'Normal',
      'Hyperreflexia',
      'Hyporeflexia',
      'Absent',
      'Not Tested'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Hernia & Reflexes",
            style: TextStyle(fontWeight: FontWeight.bold)),
        DropdownButtonFormField<String>(
          value: hernia,
          onChanged: onHerniaChanged,
          decoration: const InputDecoration(labelText: 'Hernia'),
          items: herniaOptions
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          validator: (val) =>
              val == null || val.isEmpty ? 'Select hernia status' : null,
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: papillaryReflex,
          onChanged: onPapillaryChanged,
          decoration: const InputDecoration(labelText: 'Papillary Reflex'),
          items: papillaryOptions
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          validator: (val) => val == null || val.isEmpty
              ? 'Select papillary reflex status'
              : null,
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: spinalReflex,
          onChanged: onSpinalChanged,
          decoration: const InputDecoration(labelText: 'Spinal Reflex'),
          items: spinalOptions
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          validator: (val) =>
              val == null || val.isEmpty ? 'Select spinal reflex status' : null,
        ),
      ],
    );
  }
}
