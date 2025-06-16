import 'package:automated_clinic_management_system/models/consultation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConsultationService {
  final CollectionReference _consultationCollection =
      FirebaseFirestore.instance.collection('consultations');

  Future<void> addConsultation(Consultation consultation) async {
    try {
      await _consultationCollection.add(consultation.toMap());
    } catch (e) {
      throw Exception('Failed to add consultation: $e');
    }
  }

  Stream<List<Consultation>> getConsultations({String? patientId}) {
    Query query =
        _consultationCollection.orderBy('dateCreated', descending: true);
    if (patientId != null) {
      query = query.where('patientId', isEqualTo: patientId);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Consultation.fromFirestore(doc))
          .toList();
    });
  }

  Future<Consultation?> getConsultationById(String id) async {
    try {
      final doc = await _consultationCollection.doc(id).get();
      if (doc.exists) {
        return Consultation.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch consultation: $e');
    }
  }

  Future<List<Consultation>> searchConsultations(String keyword,
      {String? patientId}) async {
    try {
      Query query = _consultationCollection;
      if (patientId != null) {
        query = query.where('patientId', isEqualTo: patientId);
      }

      final snapshot = await query.get();
      final all =
          snapshot.docs.map((doc) => Consultation.fromFirestore(doc)).toList();

      return all
          .where((c) =>
              c.complaints.toLowerCase().contains(keyword.toLowerCase()) ||
              c.diagnosis.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    } catch (e) {
      throw Exception('Search failed: $e');
    }
  }

  Stream<List<Consultation>> getConsultationsByDateRange({
    required DateTime startDate,
    required DateTime endDate,
    String? patientId,
  }) {
    Query query = _consultationCollection
        .where('dateCreated',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
        .where('dateCreated', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
        .orderBy('dateCreated', descending: true);

    if (patientId != null) {
      query = query.where('patientId', isEqualTo: patientId);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Consultation.fromFirestore(doc))
          .toList();
    });
  }

  Future<void> updateConsultation(Consultation consultation) async {
    if (consultation.id == null) {
      throw Exception('Consultation ID is null, cannot update');
    }
    try {
      await _consultationCollection
          .doc(consultation.id)
          .update(consultation.toMap());
    } catch (e) {
      throw Exception('Failed to update consultation: $e');
    }
  }

  Future<void> deleteConsultation(String consultationId) async {
    try {
      await _consultationCollection.doc(consultationId).delete();
    } catch (e) {
      throw Exception('Failed to delete consultation: $e');
    }
  }
}
