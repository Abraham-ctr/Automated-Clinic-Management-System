import 'package:cloud_firestore/cloud_firestore.dart';

class Drug {
  final String? id; // Firestore document ID, null for new drugs
  final String name;
  final int quantity;
  final String category;
  final DateTime? expiryDate;
  final String supplier;
  final int threshold;
  final DateTime createdAt;

  Drug({
    this.id,
    required this.name,
    required this.quantity,
    this.category = 'General',
    this.expiryDate,
    this.supplier = 'Unknown',
    this.threshold = 10,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Factory constructor to convert Firestore DocumentSnapshot to Drug instance
  factory Drug.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Drug(
      id: doc.id,
      name: data['name'],
      quantity: data['quantity'],
      category: data['category'] ?? 'General',
      expiryDate: data['expiryDate'] != null
          ? (data['expiryDate'] as Timestamp).toDate()
          : null,
      supplier: data['supplier'] ?? 'Unknown',
      threshold: data['threshold'] ?? 10,
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  // Convert Drug instance to a map for Firestore (exclude the id)
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'quantity': quantity,
      'category': category,
      'expiryDate': expiryDate != null ? Timestamp.fromDate(expiryDate!) : null,
      'supplier': supplier,
      'threshold': threshold,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
