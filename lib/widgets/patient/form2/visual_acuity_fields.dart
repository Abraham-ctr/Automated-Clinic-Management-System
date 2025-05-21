import 'package:flutter/material.dart';

class VisualAcuityFields extends StatelessWidget {
  final TextEditingController withoutGlassesRightController;
  final TextEditingController withoutGlassesLeftController;
  final TextEditingController withGlassesRightController;
  final TextEditingController withGlassesLeftController;

  const VisualAcuityFields({
    super.key,
    required this.withoutGlassesRightController,
    required this.withoutGlassesLeftController,
    required this.withGlassesRightController,
    required this.withGlassesLeftController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Visual Acuity Without Glasses", style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: withoutGlassesRightController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Right Eye',
                  hintText: 'e.g. 6/6',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter right eye value';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: withoutGlassesLeftController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Left Eye',
                  hintText: 'e.g. 6/9',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter left eye value';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text("Visual Acuity With Glasses", style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: withGlassesRightController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Right Eye',
                  hintText: 'e.g. 6/6',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter right eye value';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: withGlassesLeftController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Left Eye',
                  hintText: 'e.g. 6/9',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter left eye value';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
