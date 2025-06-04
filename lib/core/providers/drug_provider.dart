import 'package:automated_clinic_management_system/core/services/drug_service.dart';
import 'package:automated_clinic_management_system/models/Drug.dart';
import 'package:flutter/material.dart';

class DrugProvider with ChangeNotifier {
  final DrugService _drugService = DrugService();

  List<Drug> _allDrugs = [];
  List<Drug> get allDrugs => _allDrugs;

  List<Drug> _lowStockDrugs = [];
  List<Drug> get lowStockDrugs => _lowStockDrugs;

  List<Drug> _expiringSoonDrugs = [];
  List<Drug> get expiringSoonDrugs => _expiringSoonDrugs;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchLowStockDrugs() async {
    _isLoading = true;
    notifyListeners();

    try {
      _lowStockDrugs = await _drugService.getLowStockDrugs();
    } catch (e) {
      // Handle error appropriately
      _lowStockDrugs = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchExpiringSoonDrugs() async {
    _isLoading = true;
    notifyListeners();

    try {
      _expiringSoonDrugs = await _drugService.getExpiringSoonDrugs();
    } catch (e) {
      _expiringSoonDrugs = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  List<Drug> get expiredDrugs {
    final now = DateTime.now();
    return _allDrugs
        .where(
            (drug) => drug.expiryDate != null && drug.expiryDate!.isBefore(now))
        .toList();
  }

  int get totalDrugs => _allDrugs.length;

  int get totalQuantity =>
      _allDrugs.fold(0, (sum, drug) => sum + drug.quantity);

  Map<String, int> get categoryQuantityMap {
    final Map<String, int> map = {};
    for (var drug in _allDrugs) {
      map[drug.category] = (map[drug.category] ?? 0) + drug.quantity;
    }
    return map;
  }

  Future<void> fetchAllDrugData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allDrugs = await _drugService.getAllDrugs();
      print('Fetched drugs count: ${_allDrugs.length}'); // DEBUG

      _lowStockDrugs = _allDrugs.where((drug) => drug.quantity <= 10).toList();

      final now = DateTime.now();
      final threshold = now.add(const Duration(days: 30));
      _expiringSoonDrugs = _allDrugs.where((drug) {
        final expiry = drug.expiryDate;
        return expiry != null &&
            expiry.isAfter(now) &&
            expiry.isBefore(threshold);
      }).toList();
      print('Low stock count: ${_lowStockDrugs.length}'); // DEBUG
      print('Expiring soon count: ${_expiringSoonDrugs.length}'); // DEBUG
    } catch (e) {
      print('Error fetching drugs: $e'); // DEBUG
      _allDrugs = [];
      _lowStockDrugs = [];
      _expiringSoonDrugs = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchExpiringDrugsWithinRange(
      DateTime start, DateTime end) async {
    _isLoading = true;
    notifyListeners();

    try {
      final all = await _drugService.getAllDrugs();
      _expiringSoonDrugs = all.where((drug) {
        final expiry = drug.expiryDate;
        return expiry != null && expiry.isAfter(start) && expiry.isBefore(end);
      }).toList();
    } catch (_) {
      _expiringSoonDrugs = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
