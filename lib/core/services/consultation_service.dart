import 'package:automated_clinic_management_system/models/consultation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConsultationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'consultations';

  /// Save a new consultation
  Future<void> addConsultation(Consultation consultation) async {
    final docRef = _firestore.collection(_collectionPath).doc(consultation.id);
    await docRef.set(consultation.toMap());
  }

  /// Get consultation by id
  Future<Consultation?> getConsultationById(String id) async {
    final doc = await _firestore.collection(_collectionPath).doc(id).get();
    if (doc.exists) {
      return Consultation.fromMap(doc.data()!);
    }
    return null;
  }

  /// Get all consultations (optional: filtered by patientId)
  Future<List<Consultation>> getAllConsultations({String? patientId}) async {
    Query query = _firestore.collection(_collectionPath);

    if (patientId != null) {
      query = query.where('patientId', isEqualTo: patientId);
    }

    final querySnapshot = await query.get();

    return querySnapshot.docs
        .map((doc) => Consultation.fromMap(doc.data()! as Map<String, dynamic>))
        .toList();
  }

  /// Update an existing consultation
  Future<void> updateConsultation(
      String id, Map<String, dynamic> updatedData) async {
    await _firestore.collection(_collectionPath).doc(id).update(updatedData);
  }

  /// Delete a consultation by id
  Future<void> deleteConsultation(String id) async {
    await _firestore.collection(_collectionPath).doc(id).delete();
  }
}
