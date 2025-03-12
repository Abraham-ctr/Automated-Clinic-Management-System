import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/patient_model.dart';

class PatientService {
  final CollectionReference _patientsCollection =
      FirebaseFirestore.instance.collection("patients");

  // Add a new patient
  Future<void> addPatient(Patient patient) async {
    await _patientsCollection.doc(patient.id).set(patient.toMap());
  }

  // Get all patients
  Stream<List<Patient>> getPatients() {
    return _patientsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Patient.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }

  // Get a single patient by ID
  Future<Patient?> getPatient(String id) async {
    DocumentSnapshot doc = await _patientsCollection.doc(id).get();
    if (doc.exists) {
      return Patient.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  // Update patient details (including fitness report)
  Future<void> updatePatient(Patient patient) async {
    await _patientsCollection.doc(patient.id).update(patient.toMap());
  }

  // Delete a patient record
  Future<void> deletePatient(String id) async {
    await _patientsCollection.doc(id).delete();
  }
}
