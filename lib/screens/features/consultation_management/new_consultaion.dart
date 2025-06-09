
import 'package:automated_clinic_management_system/core/services/consultation_service.dart';
import 'package:automated_clinic_management_system/core/services/patient_service.dart';
import 'package:automated_clinic_management_system/core/utils/constants.dart';
import 'package:automated_clinic_management_system/models/consultation_model.dart';
import 'package:automated_clinic_management_system/models/patient.dart';
import 'package:automated_clinic_management_system/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class NewConsultationScreen extends StatefulWidget {
  const NewConsultationScreen({super.key});

  @override
  State<NewConsultationScreen> createState() => _NewConsultationScreenState();
}

class _NewConsultationScreenState extends State<NewConsultationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _patientService = PatientService();
  final _consultationService = ConsultationService();
  UserModel? _currentNurse;

  final _complaintsController = TextEditingController();
  final _diagnosisController = TextEditingController();
  final _treatmentController = TextEditingController();
  final _notesController = TextEditingController();

  Patient? _selectedPatient;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _selectedPatient != null && _currentNurse != null) {
    final consultation = Consultation(
      patientId: _selectedPatient!.biodata.matricNumber,
      complaints: _complaintsController.text,
      diagnosis: _diagnosisController.text,
      treatment: _treatmentController.text,
      notes: _notesController.text.isEmpty ? null : _notesController.text,
      createdBy: '${_currentNurse!.firstName} ${_currentNurse!.surname}',
      dateCreated: Timestamp.now(),
    );

      await _consultationService.addConsultation(consultation);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Consultation saved successfully')),
      );

      setState(() {
        _selectedPatient = null;
        _complaintsController.clear();
        _diagnosisController.clear();
        _treatmentController.clear();
        _notesController.clear();
      });
    }
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    IconData? icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppConstants.darkGreyColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppConstants.middleGreyColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppConstants.middleGreyColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppConstants.priColor,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: AppConstants.whiteColor,
          prefixIcon: icon != null ? Icon(icon, color: Colors.black) : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Consultation'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<List<Patient>>(
          stream: _patientService.streamAllPatients(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error loading patients: ${snapshot.error}'),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Patient',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownSearch<Patient>(
                  items: (String filter, LoadProps? loadProps) async {
                    final allPatients =
                        await _patientService.streamAllPatients().first;
                    return allPatients.where((patient) {
                      final lowerFilter = filter.toLowerCase();
                      return patient.biodata.matricNumber
                              .toLowerCase()
                              .contains(lowerFilter) ||
                          patient.biodata.surname
                              .toLowerCase()
                              .contains(lowerFilter) ||
                          patient.biodata.firstName
                              .toLowerCase()
                              .contains(lowerFilter);
                    }).toList();
                  },
                  itemAsString: (p) =>
                      '${p.biodata.matricNumber} - ${p.biodata.surname} ${p.biodata.firstName}',
                  onChanged: (patient) async {
                    await Future.delayed(const Duration(milliseconds: 300));
                    if (!mounted) return;
                    setState(() => _selectedPatient = patient);
                  },
                  selectedItem: _selectedPatient,
                  compareFn: (a, b) =>
                      a.biodata.matricNumber == b.biodata.matricNumber,
                  decoratorProps: const DropDownDecoratorProps(
                    decoration: InputDecoration(
                      labelText: 'Search by Matric Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  popupProps: const PopupProps.modalBottomSheet(
                    showSearchBox: true,
                  ),
                ),
                const SizedBox(height: 20),
                if (_selectedPatient != null)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                const Text(
                                  'Consultation Details',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                _buildTextFormField(
                                  controller: _complaintsController,
                                  label: 'Complaints',
                                  icon: Icons.report_problem,
                                  validator: (value) => value == null || value.isEmpty
                                      ? 'Enter complaints'
                                      : null,
                                ),
                                _buildTextFormField(
                                  controller: _diagnosisController,
                                  label: 'Diagnosis',
                                  icon: Icons.medical_services,
                                  validator: (value) => value == null || value.isEmpty
                                      ? 'Enter diagnosis'
                                      : null,
                                ),
                                _buildTextFormField(
                                  controller: _treatmentController,
                                  label: 'Treatment',
                                  icon: Icons.healing,
                                  validator: (value) => value == null || value.isEmpty
                                      ? 'Enter treatment'
                                      : null,
                                ),
                                _buildTextFormField(
                                  controller: _notesController,
                                  label: 'Notes (Optional)',
                                  icon: Icons.note,
                                  validator: null,
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    icon: const Icon(Icons.save),
                                    label: const Text('Submit Consultation'),
                                    onPressed: _submitForm,
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
