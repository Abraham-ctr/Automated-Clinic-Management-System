// import 'package:automated_clinic_management_system/core/services/consultation_service.dart';
// import 'package:automated_clinic_management_system/core/services/patient_service.dart';
// import 'package:automated_clinic_management_system/models/consultation_model.dart';
// import 'package:automated_clinic_management_system/models/patient_model.dart';
// import 'package:flutter/material.dart';
// import 'package:dropdown_search/dropdown_search.dart';

// class CreateConsultationScreen extends StatefulWidget {
//   const CreateConsultationScreen({super.key});

//   @override
//   _CreateConsultationScreenState createState() =>
//       _CreateConsultationScreenState();
// }

// class _CreateConsultationScreenState extends State<CreateConsultationScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final PatientService _patientService = PatientService();
//   final ConsultationService _consultationService = ConsultationService();

//   List<Patient> _patients = [];
//   Patient? _selectedPatient;

//   final TextEditingController _symptomsController = TextEditingController();
//   final TextEditingController _diagnosisController = TextEditingController();
//   final TextEditingController _treatmentController = TextEditingController();
//   final TextEditingController _doctorNameController = TextEditingController();
//   final TextEditingController _notesController = TextEditingController();

//   bool _isLoadingPatients = true;
//   bool _isSaving = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadPatients();
//   }

//   Future<void> _loadPatients() async {
//     try {
//       final patientsData = await _patientService.fetchAllPatients();
//       final patients =
//           patientsData.map((data) => Patient.fromMap(data)).toList();

//       setState(() {
//         _patients = patients;
//         _isLoadingPatients = false;
//       });
//     } catch (e) {
//       setState(() => _isLoadingPatients = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to load patients: $e')),
//       );
//     }
//   }

//   Future<void> _saveConsultation() async {
//     if (!_formKey.currentState!.validate() || _selectedPatient == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill all fields correctly.')),
//       );
//       return;
//     }

//     setState(() => _isSaving = true);

//     final consultation = Consultation(
//       id: '', // Firestore will generate the ID
//       patientId: _selectedPatient!.id,
//       symptoms: _symptomsController.text.trim(),
//       diagnosis: _diagnosisController.text.trim(),
//       treatment: _treatmentController.text.trim(),
//       doctorName: _doctorNameController.text.trim(),
//       consultationDate: DateTime.now(),
//       notes: _notesController.text.trim(),
//     );

//     try {
//       await _consultationService.addConsultation(consultation);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Consultation saved successfully.')),
//       );

//       // Clear form
//       _symptomsController.clear();
//       _diagnosisController.clear();
//       _treatmentController.clear();
//       _doctorNameController.clear();
//       _notesController.clear();

//       setState(() {
//         _selectedPatient = null;
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to save consultation: $e')),
//       );
//     } finally {
//       setState(() => _isSaving = false);
//     }
//   }

//   @override
//   void dispose() {
//     _symptomsController.dispose();
//     _diagnosisController.dispose();
//     _treatmentController.dispose();
//     _doctorNameController.dispose();
//     _notesController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Create Consultation')),
//       body: _isLoadingPatients
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: ListView(
//                   children: [
//                     DropdownSearch<Patient>(
//                       compareFn: (Patient a, Patient b) => a.id == b.id,
//                       items: (String filter, LoadProps? loadProps) {
//                         return Future.value(
//                           _patients.where((p) {
//                             final lowerFilter = filter.toLowerCase();
//                             return p.surname
//                                     .toLowerCase()
//                                     .contains(lowerFilter) ||
//                                 p.firstName
//                                     .toLowerCase()
//                                     .contains(lowerFilter) ||
//                                 p.registrationNumber
//                                     .toLowerCase()
//                                     .contains(lowerFilter);
//                           }).toList(),
//                         );
//                       },
//                       selectedItem: _selectedPatient,
//                       itemAsString: (Patient? p) => p == null
//                           ? ''
//                           : '${p.surname} ${p.firstName} (${p.registrationNumber})',
//                       popupProps: const PopupProps.menu(
//                         showSearchBox: true,
//                         searchFieldProps: TextFieldProps(
//                           decoration: InputDecoration(
//                               hintText: 'Search patients...'),
//                         ),
//                       ),
//                       onChanged: (Patient? patient) {
//                         setState(() => _selectedPatient = patient);
//                       },
//                       validator: (patient) =>
//                           patient == null ? 'Please select a patient' : null,
//                       decoratorProps: DropDownDecoratorProps(
//                         decoration: const InputDecoration(
//                           labelText: 'Patient',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _symptomsController,
//                       decoration: const InputDecoration(
//                         labelText: 'Symptoms',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (val) => val == null || val.trim().isEmpty
//                           ? 'Please enter symptoms'
//                           : null,
//                       maxLines: 2,
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _diagnosisController,
//                       decoration: const InputDecoration(
//                         labelText: 'Diagnosis',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (val) => val == null || val.trim().isEmpty
//                           ? 'Please enter diagnosis'
//                           : null,
//                       maxLines: 2,
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _treatmentController,
//                       decoration: const InputDecoration(
//                         labelText: 'Treatment',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (val) => val == null || val.trim().isEmpty
//                           ? 'Please enter treatment'
//                           : null,
//                       maxLines: 2,
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _doctorNameController,
//                       decoration: const InputDecoration(
//                         labelText: 'Doctor Name',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (val) => val == null || val.trim().isEmpty
//                           ? 'Please enter doctor name'
//                           : null,
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _notesController,
//                       decoration: const InputDecoration(
//                         labelText: 'Notes',
//                         border: OutlineInputBorder(),
//                       ),
//                       maxLines: 3,
//                     ),
//                     const SizedBox(height: 24),
//                     ElevatedButton(
//                       onPressed: _isSaving ? null : _saveConsultation,
//                       child: _isSaving
//                           ? const CircularProgressIndicator(color: Colors.white)
//                           : const Text('Save Consultation'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }
