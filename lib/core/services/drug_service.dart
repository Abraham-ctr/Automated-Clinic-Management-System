import 'package:automated_clinic_management_system/models/Drug.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DrugService {
  final CollectionReference drugsCollection =
      FirebaseFirestore.instance.collection('drugs');

  // Add a new drug with error handling
  Future<void> addDrug(Drug drug) async {
    try {
      await drugsCollection.add(drug.toFirestore());
    } catch (e) {
      // You can replace this with proper logging or Snackbar messages
      print('Error adding drug: $e');
      rethrow;
    }
  }

  // Fetch all drugs sorted by createdAt descending (newest first)
  Future<List<Drug>> getAllDrugs() async {
    try {
      final snapshot =
          await drugsCollection.orderBy('createdAt', descending: true).get();
      return snapshot.docs.map((doc) => Drug.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching drugs: $e');
      rethrow;
    }
  }

  // Stream all drugs sorted by createdAt descending
  Stream<List<Drug>> streamDrugs() {
    try {
      return drugsCollection
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => Drug.fromFirestore(doc)).toList());
    } catch (e) {
      print('Error streaming drugs: $e');
      // Return empty stream on error (optional)
      return const Stream.empty();
    }
  }

  // Update an existing drug by ID
  Future<void> updateDrug(String id, Drug updatedDrug) async {
    try {
      await drugsCollection.doc(id).update(updatedDrug.toFirestore());
    } catch (e) {
      print('Error updating drug: $e');
      rethrow;
    }
  }

  // Delete a drug by ID
  Future<void> deleteDrug(String id) async {
    try {
      await drugsCollection.doc(id).delete();
    } catch (e) {
      print('Error deleting drug: $e');
      rethrow;
    }
  }

  // Filter drugs by category (returns list)
  Future<List<Drug>> getDrugsByCategory(String category) async {
    try {
      final snapshot = await drugsCollection
          .where('category', isEqualTo: category)
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs.map((doc) => Drug.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error filtering drugs by category: $e');
      rethrow;
    }
  }

  // Filter drugs with low stock (quantity <= threshold)
  Future<List<Drug>> getLowStockDrugs() async {
    try {
      final snapshot = await drugsCollection
          .where('quantity',
              isLessThanOrEqualTo: 10) // threshold is fixed at 10
          .orderBy('quantity')
          .get();
      return snapshot.docs.map((doc) => Drug.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error filtering low stock drugs: $e');
      rethrow;
    }
  }

  Future<List<Drug>> getExpiringSoonDrugs({int days = 30}) async {
    try {
      final now = DateTime.now();
      final soon = now.add(Duration(days: days));

      final snapshot = await drugsCollection
          .where('expiryDate', isGreaterThanOrEqualTo: Timestamp.fromDate(now))
          .where('expiryDate', isLessThanOrEqualTo: Timestamp.fromDate(soon))
          .orderBy('expiryDate')
          .get();

      return snapshot.docs.map((doc) => Drug.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching expiring drugs: $e');
      rethrow;
    }
  }
}
