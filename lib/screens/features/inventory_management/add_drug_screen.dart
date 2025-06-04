import 'package:automated_clinic_management_system/core/utils/constants.dart';
import 'package:automated_clinic_management_system/core/utils/routes.dart';
import 'package:automated_clinic_management_system/models/Drug.dart';
import 'package:automated_clinic_management_system/core/services/drug_service.dart';
import 'package:automated_clinic_management_system/widgets/auth/my_button.dart';
import 'package:automated_clinic_management_system/widgets/form_header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddDrugScreen extends StatefulWidget {
  const AddDrugScreen({super.key});

  @override
  State<AddDrugScreen> createState() => _AddDrugScreenState();
}

class _AddDrugScreenState extends State<AddDrugScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String _name = '';
  int _quantity = 1;
  String _category = 'General';
  DateTime? _expiryDate;
  String _supplier = '';
  final int _threshold = 10;

  final List<String> _categories = [
    'General',
    'Antibiotic',
    'Analgesic',
    'Antipyretic',
    'Antiseptic',
    'Vaccine',
    'Vitamin',
    'Hormone',
  ];

  final DrugService _drugService = DrugService();

  Future<void> _pickExpiryDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _expiryDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 10),
    );
    if (picked != null) {
      setState(() {
        _expiryDate = picked;
      });
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() => _isLoading = true);

      final newDrug = Drug(
        name: _name,
        quantity: _quantity,
        category: _category,
        expiryDate: _expiryDate,
        supplier: _supplier.isEmpty ? 'Unknown' : _supplier,
        threshold: _threshold,
      );

      try {
        await _drugService.addDrug(newDrug);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Drug added successfully',
              style: TextStyle(color: Colors.green),
            ),
          ),
        );
        Navigator.pushReplacementNamed(context, AppRoutes.viewDrug);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to add drug: $e',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        );
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30.0, left: 30, right: 30, bottom: 10),
          child: Material(
            elevation: 10,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1000),
              // color: Colors.red,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormHeader(
                        text: "Add New Drug",
                        onPressed: () =>
                            Navigator.pushNamed(context, AppRoutes.dashboard)),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Drug Name
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Drug Name',
                                labelStyle:
                                    const TextStyle(color: Colors.black87),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppConstants.middleGreyColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppConstants.priColor, width: 2),
                                ),
                              ),
                              validator: (value) =>
                                  value == null || value.trim().isEmpty
                                      ? 'Enter drug name'
                                      : null,
                              onSaved: (value) => _name = value!.trim(),
                            ),
                            const SizedBox(height: 16),

                            // Quantity counter
                            Row(
                              children: [
                                const Text('Quantity Available',
                                    style: TextStyle(fontSize: 16)),
                                const SizedBox(
                                  width: 30,
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: _quantity > 1
                                          ? () => setState(() => _quantity--)
                                          : null,
                                      icon: const Icon(Icons.remove),
                                      color: Colors.redAccent,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '$_quantity',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                      onPressed: () =>
                                          setState(() => _quantity++),
                                      icon: const Icon(Icons.add),
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Category Dropdown
                            DropdownButtonFormField<String>(
                              value: _category,
                              decoration: InputDecoration(
                                labelText: 'Category',
                                labelStyle:
                                    const TextStyle(color: Colors.black87),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppConstants.middleGreyColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppConstants.priColor, width: 2),
                                ),
                              ),
                              items: _categories.map((cat) {
                                return DropdownMenuItem(
                                  value: cat,
                                  child: Text(cat,
                                      style: const TextStyle(
                                          color: Colors.black87)),
                                );
                              }).toList(),
                              onChanged: (value) =>
                                  setState(() => _category = value!),
                              dropdownColor: AppConstants.whiteColor,
                              style: const TextStyle(color: Colors.black87),
                            ),
                            const SizedBox(height: 16),

                            // Expiry Date Picker
                            GestureDetector(
                              onTap: _pickExpiryDate,
                              child: AbsorbPointer(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Expiry Date',
                                    labelStyle:
                                        const TextStyle(color: Colors.black87),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    suffixIcon: const Icon(Icons.calendar_today,
                                        color: AppConstants.priColor),
                                  ),
                                  controller: TextEditingController(
                                    text: _expiryDate == null
                                        ? ''
                                        : DateFormat('yyyy-MM-dd')
                                            .format(_expiryDate!),
                                  ),
                                  style: const TextStyle(color: Colors.black87),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Supplier field
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Supplier (optional)',
                                labelStyle:
                                    const TextStyle(color: Colors.black87),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppConstants.middleGreyColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppConstants.priColor, width: 2),
                                ),
                              ),
                              onSaved: (value) =>
                                  _supplier = value?.trim() ?? '',
                              style: const TextStyle(color: Colors.black87),
                            ),
                            const SizedBox(height: 16),

                            // Threshold display
                            Text(
                              'Threshold: $_threshold',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Submit Button (uses custom MyButton)
                            MyButton(
                              text: 'Add Drug',
                              onPressed: _isLoading ? null : _submit,
                              isPrimary: true,
                              isLoading: _isLoading,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
