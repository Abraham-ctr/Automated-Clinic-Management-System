import 'package:automated_clinic_management_system/models/patient_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientService {
  final CollectionReference _patientRef =
      FirebaseFirestore.instance.collection('patients');

  // Saving a Patient to Firestore
  Future<void> addPatient(Patient patient) async {
    try {
      // Add without ID first to let Firestore generate it
      DocumentReference docRef = await _patientRef.add(patient.toMap());

      // Then update the document with its own ID as 'id' field
      await docRef.update({'id': docRef.id});
    } catch (e) {
      rethrow;
    }
  }

  // Fetching All Patients
  Future<List<Patient>> getAllPatients() async {
    try {
      QuerySnapshot snapshot = await _patientRef.get();
      return snapshot.docs
          .map((doc) => Patient.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  // Fetching a Single Patient by ID
  Future<Patient?> getPatientById(String id) async {
    try {
      DocumentSnapshot doc = await _patientRef.doc(id).get();
      if (doc.exists) {
        return Patient.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  // Updating a Patient
  Future<void> updatePatient(Patient patient) async {
    try {
      await _patientRef.doc(patient.id).update(patient.toMap());
    } catch (e) {
      rethrow;
    }
  }

  // Deleting a Patient
  Future<void> deletePatient(String id) async {
    try {
      await _patientRef.doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  // Search by Registration Number
  Future<Patient?> searchByRegistrationNumber(String regNo) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('patients')
          .where('registrationNumber', isEqualTo: regNo)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return Patient.fromMap(
            snapshot.docs.first.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  // Filter by Department
  Future<List<Patient>> filterByDepartment(String department) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('patients')
          .where('department', isEqualTo: department)
          .get();

      return snapshot.docs
          .map((doc) => Patient.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
