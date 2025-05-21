import 'package:flutter/material.dart';

class HeartAndBPFields extends StatelessWidget {
  final String? heart;
  final String? bloodPressure;
  final void Function(String?) onHeartChanged;
  final void Function(String) onBloodPressureChanged;

  const HeartAndBPFields({
    super.key,
    required this.heart,
    required this.bloodPressure,
    required this.onHeartChanged,
    required this.onBloodPressureChanged,
  });

  @override
  Widget build(BuildContext context) {
    final heartOptions = ['Normal', 'Murmur', 'Irregular', 'Abnormal'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Heart & Blood Pressure",
            style: TextStyle(fontWeight: FontWeight.bold)),
        DropdownButtonFormField<String>(
          value: heart,
          onChanged: onHeartChanged,
          decoration: const InputDecoration(labelText: 'Heart'),
          items: heartOptions
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          validator: (value) =>
              value == null || value.isEmpty ? 'Select heart condition' : null,
        ),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: bloodPressure,
          onChanged: onBloodPressureChanged,
          keyboardType: TextInputType.text,
          decoration:
              const InputDecoration(labelText: 'Blood Pressure (e.g. 120/80)'),
          validator: (value) =>
              value == null || value.isEmpty ? 'Enter BP' : null,
        ),
      ],
    );
  }
}
