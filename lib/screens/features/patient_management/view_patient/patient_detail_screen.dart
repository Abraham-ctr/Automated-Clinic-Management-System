import 'package:flutter/material.dart';
import 'package:automated_clinic_management_system/models/patient.dart';
import 'package:intl/intl.dart';

class PatientDetailScreen extends StatelessWidget {
  final Patient patient;

  const PatientDetailScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    final biodata = patient.biodata;
    final test = patient.medicalTest;
    final created = patient.dateTimeCreated;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Biodata'),
            _infoTile('Full Name',
                '${biodata.surname} ${biodata.firstName} ${biodata.otherNames}'),
            _infoTile('Matric Number', biodata.matricNumber),
            _infoTile('Gender', biodata.sex),
            _infoTile('Date of Birth',
                DateFormat.yMMMd().format(biodata.dateOfBirth)),
            _infoTile('Phone Number', biodata.phoneNumber),
            const SizedBox(height: 24),
            _sectionTitle('Medical Test'),
            ...[
              _infoTile('Height (cm)', test.heightCm.toString()),
              _infoTile('Weight (kg)', test.weightKg.toString()),
              _infoTile('Blood Pressure', test.bloodPressure),
              _infoTile('Blood Group', test.bloodGroup),
              _infoTile('Genotype', test.genotype),
            ],
            const SizedBox(height: 24),
            _infoTile('Registered On', DateFormat.yMMMMd().format(created)),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget _infoTile(String label, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(value),
    );
  }
}
