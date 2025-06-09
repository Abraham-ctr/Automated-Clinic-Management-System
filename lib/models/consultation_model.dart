import 'package:cloud_firestore/cloud_firestore.dart';

class Consultation {
  final String? id;              // Firestore doc ID (nullable for new docs)
  final String patientId;        // Link to Patient doc ID
  final String complaints;
  final String diagnosis;
  final String treatment;
  final String? notes;           // optional
  final Timestamp dateCreated;   // Firestore timestamp
  final String createdBy;        // nurse ID or name who created it

  Consultation({
    this.id,
    required this.patientId,
    required this.complaints,
    required this.diagnosis,
    required this.treatment,
    this.notes,
    required this.dateCreated,
    required this.createdBy,
  });

  // Factory to create from Firestore doc snapshot
  factory Consultation.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Consultation(
      id: doc.id,
      patientId: data['patientId'] as String,
      complaints: data['complaints'] as String,
      diagnosis: data['diagnosis'] as String,
      treatment: data['treatment'] as String,
      notes: data['notes'] as String?,
      dateCreated: data['dateCreated'] as Timestamp,
      createdBy: data['createdBy'] as String,
    );
  }

  // Convert model to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'complaints': complaints,
      'diagnosis': diagnosis,
      'treatment': treatment,
      'notes': notes,
      'dateCreated': dateCreated,
      'createdBy': createdBy,
    };
  }
}
