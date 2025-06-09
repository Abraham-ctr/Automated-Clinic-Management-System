import 'package:automated_clinic_management_system/models/consultation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConsultationService {
  final CollectionReference _consultationCollection =
      FirebaseFirestore.instance.collection('consultations');

  /// Add a new consultation to Firestore
  Future<void> addConsultation(Consultation consultation) async {
    try {
      await _consultationCollection.add(consultation.toMap());
    } catch (e) {
      // Handle error appropriately in your app
      throw Exception('Failed to add consultation: $e');
    }
  }

  /// Fetch consultations optionally filtered by patientId
  Stream<List<Consultation>> getConsultations({String? patientId}) {
    Query query = _consultationCollection.orderBy('dateCreated', descending: true);

    if (patientId != null) {
      query = query.where('patientId', isEqualTo: patientId);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Consultation.fromFirestore(doc);
      }).toList();
    });
  }

  /// Optional: Update an existing consultation
  Future<void> updateConsultation(Consultation consultation) async {
    if (consultation.id == null) {
      throw Exception('Consultation ID is null, cannot update');
    }
    try {
      await _consultationCollection.doc(consultation.id).update(consultation.toMap());
    } catch (e) {
      throw Exception('Failed to update consultation: $e');
    }
  }

  /// Optional: Delete a consultation
  Future<void> deleteConsultation(String consultationId) async {
    try {
      await _consultationCollection.doc(consultationId).delete();
    } catch (e) {
      throw Exception('Failed to delete consultation: $e');
    }
  }
}
