import 'package:automated_clinic_management_system/models/patient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientService {
  final CollectionReference _patientsCollection;

  PatientService()
      : _patientsCollection = FirebaseFirestore.instance.collection('patients');

  // Save biodata only, merge with existing doc
  Future<void> saveBiodata(PatientBiodata biodata) async {
    final docRef = _patientsCollection.doc(biodata.matricNumber);
    await docRef.set({
      'biodata': biodata.toMap(),
      'dateTimeCreated': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // Save medical test only, merge with existing doc
  Future<void> saveMedicalTest(
      String matricNumber, PatientMedicalTest medicalTest) async {
    final docRef = _patientsCollection.doc(matricNumber);
    await docRef.set({
      'medicalTest': medicalTest.toMap(),
    }, SetOptions(merge: true));
  }

  // Get patient by matric number (both biodata and medical test)
  Future<Patient?> getPatient(String matricNumber) async {
    final docSnapshot = await _patientsCollection.doc(matricNumber).get();
    if (!docSnapshot.exists) return null;

    final data = docSnapshot.data() as Map<String, dynamic>;
    return Patient.fromMap(data);
  }

  // Check if patient exists
  Future<bool> patientExists(String matricNumber) async {
    final docSnapshot = await _patientsCollection.doc(matricNumber).get();
    return docSnapshot.exists;
  }

  // Delete a patient document
  Future<void> deletePatient(String matricNumber) async {
    await _patientsCollection.doc(matricNumber).delete();
  }

  // Optional: List all patients (just returns documents snapshot)
  Stream<List<Patient>> streamAllPatients() {
    return _patientsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Patient.fromMap(data);
      }).toList();
    });
  }
}
