import 'package:flutter/material.dart';

class FinalFormSection extends StatelessWidget {
  final String? otherObservation;
  final String? remarks;
  final DateTime? date;
  final String? medicalOfficerName;
  final String? hospitalAddress;

  final void Function(String?) onOtherObservationChanged;
  final void Function(String?) onRemarksChanged;
  final void Function(DateTime) onDateChanged;
  final void Function(String?) onMedicalOfficerNameChanged;
  final void Function(String?) onHospitalAddressChanged;

  const FinalFormSection({
    super.key,
    required this.otherObservation,
    required this.remarks,
    required this.date,
    required this.medicalOfficerName,
    required this.hospitalAddress,
    required this.onOtherObservationChanged,
    required this.onRemarksChanged,
    required this.onDateChanged,
    required this.onMedicalOfficerNameChanged,
    required this.onHospitalAddressChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Other Observations & Final Info",
            style: TextStyle(fontWeight: FontWeight.bold)),
        TextFormField(
          initialValue: otherObservation,
          decoration: const InputDecoration(labelText: 'Other Observation'),
          maxLines: 3,
          onChanged: onOtherObservationChanged,
        ),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: remarks,
          decoration: const InputDecoration(labelText: 'Remarks'),
          maxLines: 3,
          onChanged: onRemarksChanged,
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: date ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            );
            if (picked != null) onDateChanged(picked);
          },
          child: InputDecorator(
            decoration: const InputDecoration(labelText: 'Date'),
            child: Text(
              date != null
                  ? '${date!.day}/${date!.month}/${date!.year}'
                  : 'Select date',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: medicalOfficerName,
          decoration: const InputDecoration(labelText: 'Medical Officer Name'),
          onChanged: onMedicalOfficerNameChanged,
          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        ),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: hospitalAddress,
          decoration: const InputDecoration(labelText: 'Hospital Address'),
          maxLines: 2,
          onChanged: onHospitalAddressChanged,
          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        ),
      ],
    );
  }
}
