import 'package:flutter/material.dart';

class HeightWeightFields extends StatelessWidget {
  final TextEditingController heightMetersController;
  final TextEditingController heightCmController;
  final TextEditingController weightKgController;
  final TextEditingController weightGController;

  const HeightWeightFields({
    Key? key,
    required this.heightMetersController,
    required this.heightCmController,
    required this.weightKgController,
    required this.weightGController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Height", style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: heightMetersController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Meters',
                  hintText: 'e.g. 1',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter meters';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: heightCmController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Centimeters',
                  hintText: 'e.g. 75',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter cm';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text("Weight", style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: weightKgController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Kilograms',
                  hintText: 'e.g. 55',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter kg';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: weightGController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Grams',
                  hintText: 'e.g. 500',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter g';
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
