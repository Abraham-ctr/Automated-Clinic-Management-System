import 'package:automated_clinic_management_system/core/services/consultation_service.dart';
import 'package:automated_clinic_management_system/models/consultation_model.dart';
import 'package:flutter/material.dart';

class EditConsultationScreen extends StatefulWidget {
  final Consultation consultation;

  const EditConsultationScreen({super.key, required this.consultation});

  @override
  State<EditConsultationScreen> createState() => _EditConsultationScreenState();
}

class _EditConsultationScreenState extends State<EditConsultationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  late TextEditingController _complaintsController;
  late TextEditingController _diagnosisController;
  late TextEditingController _treatmentController;
  late TextEditingController _notesController;

  final _consultationService = ConsultationService();

  @override
  void initState() {
    super.initState();
    _complaintsController = TextEditingController(text: widget.consultation.complaints);
    _diagnosisController = TextEditingController(text: widget.consultation.diagnosis);
    _treatmentController = TextEditingController(text: widget.consultation.treatment);
    _notesController = TextEditingController(text: widget.consultation.notes ?? '');
  }

  Future<void> _updateConsultation() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final updatedConsultation = Consultation(
      id: widget.consultation.id,
      patientId: widget.consultation.patientId,
      complaints: _complaintsController.text,
      diagnosis: _diagnosisController.text,
      treatment: _treatmentController.text,
      notes: _notesController.text.isEmpty ? null : _notesController.text,
      createdBy: widget.consultation.createdBy,
      dateCreated: widget.consultation.dateCreated,
    );

    try {
      await _consultationService.updateConsultation(updatedConsultation);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Consultation updated')),
      );

      Navigator.pop(context, 'updated');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _complaintsController.dispose();
    _diagnosisController.dispose();
    _treatmentController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Consultation')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _complaintsController,
                      decoration: const InputDecoration(labelText: 'Complaints'),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter complaints' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _diagnosisController,
                      decoration: const InputDecoration(labelText: 'Diagnosis'),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter diagnosis' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _treatmentController,
                      decoration: const InputDecoration(labelText: 'Treatment'),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter treatment' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _notesController,
                      decoration: const InputDecoration(labelText: 'Notes (Optional)'),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _updateConsultation,
                      child: const Text('Save Changes'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
