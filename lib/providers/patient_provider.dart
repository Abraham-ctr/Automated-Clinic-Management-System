import 'package:automated_clinic_management_system/services/patient_services.dart';
import 'package:flutter/material.dart';
import '../models/patient_model.dart';

class PatientProvider with ChangeNotifier {
  final PatientService _patientService = PatientService();
  List<Patient> _patients = [];

  List<Patient> get patients => _patients;

  // Load patients from Firestore
  void loadPatients() {
    _patientService.getPatients().listen((patientList) {
      _patients = patientList;
      notifyListeners();
    });
  }

  // Add a new patient
  Future<void> addPatient(Patient patient) async {
    await _patientService.addPatient(patient);
    loadPatients(); // Refresh the list
  }

  // Update a patient
  Future<void> updatePatient(Patient patient) async {
    await _patientService.updatePatient(patient);
    loadPatients();
  }

  // Delete a patient
  Future<void> deletePatient(String id) async {
    await _patientService.deletePatient(id);
    loadPatients();
  }
}
