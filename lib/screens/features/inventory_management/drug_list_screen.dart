import 'package:automated_clinic_management_system/core/utils/constants.dart';
import 'package:automated_clinic_management_system/core/utils/routes.dart';
import 'package:automated_clinic_management_system/screens/features/inventory_management/add_drug_screen.dart';
import 'package:automated_clinic_management_system/widgets/form_header.dart';
import 'package:flutter/material.dart';
import 'package:automated_clinic_management_system/models/Drug.dart';
import 'package:automated_clinic_management_system/core/services/drug_service.dart';

class DrugListScreen extends StatefulWidget {
  const DrugListScreen({super.key});

  @override
  State<DrugListScreen> createState() => _DrugListScreenState();
}

class _DrugListScreenState extends State<DrugListScreen> {
  final DrugService _drugService = DrugService();
  final Map<String, bool> _isSaving = {};

  // Track which drug is currently being edited by id
  String? _editingDrugId;

  // Controllers and temp variables for editing
  final Map<String, TextEditingController> _nameControllers = {};
  final Map<String, int> _quantityValues = {};
  final Map<String, String> _categoryValues = {};
  final Map<String, DateTime?> _expiryDates = {};
  final Map<String, TextEditingController> _supplier = {};

  // Example categories, match your dropdown list
  final List<String> _categories = [
    'General',
    'Antibiotic',
    'Analgesic',
    'Antiseptic',
    'Vaccine',
    'Vitamin',
    'Hormone',
    'Sedative',
  ];

  @override
  void dispose() {
    // Dispose all controllers
    for (var c in _nameControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _startEditing(Drug drug) {
    setState(() {
      _editingDrugId = drug.id;
      _nameControllers[drug.id!] = TextEditingController(text: drug.name);
      _quantityValues[drug.id!] = drug.quantity;
      _categoryValues[drug.id!] = drug.category;
      _expiryDates[drug.id!] = drug.expiryDate;
      _supplier[drug.id!] = TextEditingController(text: drug.supplier);
    });
  }

  void _cancelEditing(String drugId) {
    setState(() {
      _editingDrugId = null;
      _nameControllers[drugId]?.dispose();
      _nameControllers.remove(drugId);
      _quantityValues.remove(drugId);
      _categoryValues.remove(drugId);
      _expiryDates.remove(drugId);
    });
  }

  Future<void> _saveEditing(String drugId) async {
    final name = _nameControllers[drugId]?.text.trim();
    final quantity = _quantityValues[drugId];
    final category = _categoryValues[drugId];
    final expiryDate = _expiryDates[drugId];
    final supplier = _supplier[drugId]?.text.trim();

    if (name == null || name.isEmpty || quantity == null || category == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all required fields')));
      return;
    }

    setState(() {
      _isSaving[drugId] = true;
    });

    final updatedDrug = Drug(
      id: drugId,
      name: name,
      quantity: quantity,
      category: category,
      expiryDate: expiryDate,
      threshold: 10,
      supplier: supplier?.isEmpty ?? true ? 'Unknown' : supplier!,
    );

    try {
      await _drugService.updateDrug(drugId, updatedDrug);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Drug updated successfully')));
      _cancelEditing(drugId);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() {
        _isSaving[drugId] = false;
      });
    }
  }

  Future<void> _deleteDrug(String drugId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Delete Drug',
        ),
        content: const Text('Are you sure you want to delete this drug?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
            ),
          ),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(AppConstants.secColor),
              ),
              child: const Text(
                'Delete',
                style: TextStyle(color: AppConstants.whiteColor),
              )),
        ],
      ),
    );
    if (confirmed == true) {
      try {
        await _drugService.deleteDrug(drugId);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Drug deleted successfully')));
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  // Quantity counter widget for editing
  Widget _buildQuantityCounter(String drugId) {
    final quantity = _quantityValues[drugId] ?? 0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          color: Colors.redAccent,
          onPressed: quantity > 0
              ? () {
                  setState(() {
                    _quantityValues[drugId] = quantity - 1;
                  });
                }
              : null,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          quantity.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          icon: const Icon(Icons.add),
          color: Colors.green,
          onPressed: () {
            setState(() {
              _quantityValues[drugId] = quantity + 1;
            });
          },
        ),
      ],
    );
  }

  // Date picker for editing expiry date
  Future<void> _pickExpiryDate(String drugId) async {
    final currentDate = _expiryDates[drugId] ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _expiryDates[drugId] = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          FormHeader(
              text: 'Drug Inventory',
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.dashboard)),
          Flexible(
            child: StreamBuilder<List<Drug>>(
              stream: _drugService.streamDrugs(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final drugs = snapshot.data!;
                if (drugs.isEmpty) {
                  return const Center(child: Text('No drugs available'));
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: ListView.builder(
                    itemCount: drugs.length,
                    itemBuilder: (context, index) {
                      final drug = drugs[index];
                      final isEditing = drug.id == _editingDrugId;
                      final lowStock = drug.quantity <= drug.threshold;

                      if (isEditing) {
                        return Card(
                          margin: const EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Name input
                                TextFormField(
                                  controller: _nameControllers[drug.id!],
                                  decoration: InputDecoration(
                                    labelText: 'Drug Name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: AppConstants.middleGreyColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: AppConstants.priColor,
                                          width: 2),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                // Quantity counter
                                Row(
                                  children: [
                                    const Text('Quantity: '),
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: _buildQuantityCounter(drug.id!)),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                // Category dropdown
                                DropdownButtonFormField<String>(
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
                                          color: AppConstants.priColor,
                                          width: 2),
                                    ),
                                  ),
                                  value: _categories
                                          .contains(_categoryValues[drug.id!])
                                      ? _categoryValues[drug.id!]
                                      : null,
                                  hint: const Text('Select category'),
                                  items: _categories
                                      .map((c) => DropdownMenuItem(
                                            value: c,
                                            child: Text(c),
                                          ))
                                      .toList(),
                                  onChanged: (val) {
                                    if (val != null) {
                                      setState(() {
                                        _categoryValues[drug.id!] = val;
                                      });
                                    }
                                  },
                                ),

                                const SizedBox(height: 20),
                                // Expiry date picker
                                Row(
                                  children: [
                                    const Text('Expiry Date: '),
                                    Text(
                                      _expiryDates[drug.id!] != null
                                          ? "${_expiryDates[drug.id!]!.toLocal()}"
                                              .split(' ')[0]
                                          : 'None',
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          _pickExpiryDate(drug.id!),
                                      child: const Text(
                                        'Pick Date',
                                        style: TextStyle(
                                            color: AppConstants.secColor),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),

                                // supplier
                                TextFormField(
                                  controller: _supplier[drug.id!],
                                  decoration: InputDecoration(
                                    labelText: 'Supplier',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: AppConstants.middleGreyColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: AppConstants.priColor,
                                          width: 2),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 18),
                                // Save & Cancel buttons
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () => _cancelEditing(drug.id!),
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: _isSaving[drug.id!] == true
                                          ? null
                                          : () => _saveEditing(drug.id!),
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              const WidgetStatePropertyAll(
                                                  AppConstants.secColor)),
                                      child: _isSaving[drug.id!] == true
                                          ? const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.white),
                                              ),
                                            )
                                          : const Text(
                                              'Save',
                                              style: TextStyle(
                                                  color:
                                                      AppConstants.whiteColor),
                                            ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }

                      // Not editing mode, just viewing — display drug info with edit/delete icons
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(
                            drug.name,
                            style: TextStyle(
                              color: lowStock
                                  ? Colors.red
                                  : const Color.fromARGB(255, 0, 255, 8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Qty: ${drug.quantity} | Category: ${drug.category} | Expiry Date: ${drug.expiryDate != null ? drug.expiryDate!.toLocal().toString().split(' ')[0] : 'None'} | Supplier: ${drug.supplier}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                tooltip: 'Edit',
                                icon: const Icon(
                                  Icons.edit,
                                  color: AppConstants.secColor,
                                ),
                                onPressed: () => _startEditing(drug),
                              ),
                              IconButton(
                                tooltip: 'Delete',
                                icon: const Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  if (drug.id != null) _deleteDrug(drug.id!);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add New Drug",
        backgroundColor: AppConstants.priColor,
        onPressed: () {
          // Navigate to your AddDrugScreen
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddDrugScreen()),
          );
        },
        child: const Icon(
          Icons.add,
          color: AppConstants.whiteColor,
          size: 44,
        ),
      ),
    );
  }
}
