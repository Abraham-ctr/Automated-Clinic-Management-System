import 'package:flutter/material.dart';

class ChestXRayFields extends StatelessWidget {
  final String? filmNo;
  final String? hospital;
  final String? report;

  final void Function(String?) onFilmNoChanged;
  final void Function(String?) onHospitalChanged;
  final void Function(String?) onReportChanged;

  const ChestXRayFields({
    super.key,
    required this.filmNo,
    required this.hospital,
    required this.report,
    required this.onFilmNoChanged,
    required this.onHospitalChanged,
    required this.onReportChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Chest X-Ray",
            style: TextStyle(fontWeight: FontWeight.bold)),
        TextFormField(
          initialValue: filmNo,
          decoration: const InputDecoration(labelText: 'Film Number'),
          onChanged: onFilmNoChanged,
          validator: (val) =>
              val == null || val.isEmpty ? 'Enter film number' : null,
        ),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: hospital,
          decoration: const InputDecoration(labelText: 'Hospital'),
          onChanged: onHospitalChanged,
          validator: (val) =>
              val == null || val.isEmpty ? 'Enter hospital name' : null,
        ),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: report,
          decoration: const InputDecoration(labelText: 'Radiologist\'s Report'),
          maxLines: 4,
          onChanged: onReportChanged,
          validator: (val) =>
              val == null || val.isEmpty ? 'Enter report' : null,
        ),
      ],
    );
  }
}
