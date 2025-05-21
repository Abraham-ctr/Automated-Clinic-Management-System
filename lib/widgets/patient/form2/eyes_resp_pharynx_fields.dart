import 'package:flutter/material.dart';

class EyesRespPharynxFields extends StatelessWidget {
  final String? eyes;
  final String? respiratorySystem;
  final String? pharynx;
  final void Function(String?) onEyesChanged;
  final void Function(String?) onRespChanged;
  final void Function(String?) onPharynxChanged;

  const EyesRespPharynxFields({
    super.key,
    required this.eyes,
    required this.respiratorySystem,
    required this.pharynx,
    required this.onEyesChanged,
    required this.onRespChanged,
    required this.onPharynxChanged,
  });

  @override
  Widget build(BuildContext context) {
    final eyeOptions = ['Normal', 'Redness', 'Jaundice', 'Discharge', 'Abnormal'];
    final respOptions = ['Normal', 'Wheezing', 'Crackles', 'Abnormal'];
    final pharynxOptions = ['Normal', 'Inflamed', 'Congested', 'Abnormal'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Eyes, Respiratory System, Pharynx", style: TextStyle(fontWeight: FontWeight.bold)),

        DropdownButtonFormField<String>(
          value: eyes,
          onChanged: onEyesChanged,
          decoration: const InputDecoration(labelText: 'Eyes'),
          items: eyeOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          validator: (value) => value == null || value.isEmpty ? 'Select eye condition' : null,
        ),

        const SizedBox(height: 12),

        DropdownButtonFormField<String>(
          value: respiratorySystem,
          onChanged: onRespChanged,
          decoration: const InputDecoration(labelText: 'Respiratory System'),
          items: respOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          validator: (value) => value == null || value.isEmpty ? 'Select respiratory state' : null,
        ),

        const SizedBox(height: 12),

        DropdownButtonFormField<String>(
          value: pharynx,
          onChanged: onPharynxChanged,
          decoration: const InputDecoration(labelText: 'Pharynx'),
          items: pharynxOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          validator: (value) => value == null || value.isEmpty ? 'Select pharynx condition' : null,
        ),
      ],
    );
  }
}
