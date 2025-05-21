import 'package:cloud_firestore/cloud_firestore.dart';

class PatientService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Save Part 1 of the medical form to patients/{patientId}/form1
  Future<void> saveForm1({
    required String patientId,
    required Map<String, dynamic> form1Data,
  }) async {
    try {
      await _firestore.collection('patients').doc(patientId).set({
        'form1': form1Data,
      }, SetOptions(merge: true)); // merge = don’t overwrite form2
    } catch (e) {
      throw Exception('Failed to save Form 1: $e');
    }
  }

  /// Save Part 2 of the medical form to patients/{patientId}/form2
  Future<void> saveForm2({
    required String patientId,
    required Map<String, dynamic> form2Data,
  }) async {
    try {
      await _firestore.collection('patients').doc(patientId).set({
        'form2': form2Data,
      }, SetOptions(merge: true)); // merge = don’t overwrite form1
    } catch (e) {
      throw Exception('Failed to save Form 2: $e');
    }
  }

  /// Optional: Get both forms' data (form1 + form2) for a patient
  Future<Map<String, dynamic>?> getPatientForms(String patientId) async {
    try {
      final docSnapshot =
          await _firestore.collection('patients').doc(patientId).get();
      if (docSnapshot.exists) {
        return docSnapshot.data();
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get patient data: $e');
    }
  }

  /// Optional: Delete a patient entirely
  Future<void> deletePatient(String patientId) async {
    try {
      await _firestore.collection('patients').doc(patientId).delete();
    } catch (e) {
      throw Exception('Failed to delete patient: $e');
    }
  }
}
