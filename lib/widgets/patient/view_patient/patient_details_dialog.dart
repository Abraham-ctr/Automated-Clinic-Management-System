import 'package:automated_clinic_management_system/core/services/patient_service.dart';
import 'package:flutter/material.dart';

class _PatientDetailsDialog extends StatefulWidget {
  final Map<String, dynamic> patient;
  final Function(Map<String, dynamic>) onSave;
  final VoidCallback onDelete;

  const _PatientDetailsDialog({
    required this.patient,
    required this.onSave,
    required this.onDelete,
  });

  @override
  State<_PatientDetailsDialog> createState() => _PatientDetailsDialogState();
}

class _PatientDetailsDialogState extends State<_PatientDetailsDialog> {
  final _formKey = GlobalKey<FormState>();
  final _surnameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  late Map<String, dynamic> _form1;
  late Map<String, dynamic> _form2;

  @override
  void initState() {
    super.initState();
    _form1 = Map<String, dynamic>.from(widget.patient['form1'] ?? {});
    _form2 = Map<String, dynamic>.from(widget.patient['form2'] ?? {});

    _surnameController.text = _form1['surname'] ?? '';
    _firstNameController.text = _form1['firstName'] ?? '';
    _heightController.text = _form2['height']?.toString() ?? '';
    _weightController.text = _form2['weight']?.toString() ?? '';
  }

  @override
  void dispose() {
    _surnameController.dispose();
    _firstNameController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      _form1['surname'] = _surnameController.text.trim();
      _form1['firstName'] = _firstNameController.text.trim();
      _form2['height'] = _heightController.text.trim();
      _form2['weight'] = _weightController.text.trim();

      final updatedData = {
        'form1': _form1,
        'form2': _form2,
      };

      // await PatientService().updatePatient(widget.patient['id'], updatedData);

      widget.onSave({
        ...widget.patient,
        'form1': _form1,
        'form2': _form2,
      });

      Navigator.of(context).pop();
    }
  }

  void _delete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this patient?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Delete')),
        ],
      ),
    );

    if (confirm == true) {
      await PatientService().deletePatient(widget.patient['id']);
      widget.onDelete();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Patient'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _surnameController,
                decoration: const InputDecoration(labelText: 'Surname'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(labelText: 'Height (cm)'),
              ),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Weight (kg)'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: _delete, child: const Text('Delete')),
        ElevatedButton(onPressed: _save, child: const Text('Save')),
      ],
    );
  }
}
