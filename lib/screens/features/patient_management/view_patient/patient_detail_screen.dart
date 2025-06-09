import 'package:automated_clinic_management_system/core/services/patient_service.dart';
import 'package:automated_clinic_management_system/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatientDetailScreen extends StatefulWidget {
  final Patient patient;

  const PatientDetailScreen({super.key, required this.patient});

  @override
  State<PatientDetailScreen> createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen>
    with SingleTickerProviderStateMixin {
  final PatientService _patientService = PatientService();

  late TabController _tabController;
  late PatientBiodata _biodata;
  late PatientMedicalTest _medicalTest;
  late PatientBiodata _editableBiodata;
  late PatientMedicalTest _editableMedicalTest;

  bool isEditing = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _biodata = widget.patient.biodata;
    _medicalTest = widget.patient.medicalTest;
    _editableBiodata = _deepCopyBiodata(_biodata);
    _editableMedicalTest = _deepCopyMedicalTest(_medicalTest);
    _tabController = TabController(length: 2, vsync: this);
  }

  // Deep copies to avoid editing original references
  PatientBiodata _deepCopyBiodata(PatientBiodata biodata) {
    return biodata.copyWith();
  }

  PatientMedicalTest _deepCopyMedicalTest(PatientMedicalTest medicalTest) {
    return medicalTest.copyWith();
  }

  void _startEditing() {
    setState(() {
      isEditing = true;
      _editableBiodata = _deepCopyBiodata(_biodata);
      _editableMedicalTest = _deepCopyMedicalTest(_medicalTest);
    });
  }

  void _cancelEditing() {
    setState(() {
      isEditing = false;
      _editableBiodata = _deepCopyBiodata(_biodata);
      _editableMedicalTest = _deepCopyMedicalTest(_medicalTest);
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      // Form invalid, do not save
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix errors before saving')),
      );
      return;
    }
    try {
      await _patientService.saveBiodata(_editableBiodata);
      await _patientService.saveMedicalTest(
          _editableBiodata.matricNumber, _editableMedicalTest);

      setState(() {
        _biodata = _deepCopyBiodata(_editableBiodata);
        _medicalTest = _deepCopyMedicalTest(_editableMedicalTest);
        isEditing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Patient data saved successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save patient data: $e')),
      );
    }
  }

  Future<void> _delete() async {
    final matricNumber = _biodata.matricNumber;
    if (matricNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid patient matric number')),
      );
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this patient?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Delete')),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await _patientService.deletePatient(matricNumber);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Patient deleted successfully')),
      );

      if (mounted) Navigator.of(context).pop(); // Go back after delete
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete patient: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Biodata'),
            Tab(text: 'Medical Test'),
          ],
        ),
        actions: [
          if (!isEditing)
            IconButton(icon: const Icon(Icons.edit), onPressed: _startEditing),
          if (isEditing) ...[
            IconButton(
                icon: const Icon(Icons.save),
                onPressed: () async => await _save()),
            IconButton(
                icon: const Icon(Icons.cancel), onPressed: _cancelEditing),
          ],
          IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async => await _delete()),
        ],
      ),
      body: Form(
        key: _formKey,
        child: TabBarView(
          controller: _tabController,
          children: [
            isEditing ? _buildEditableBiodataTab() : _buildReadOnlyBiodataTab(),
            isEditing
                ? _buildEditableMedicalTestTab()
                : _buildReadOnlyMedicalTestTab(),
          ],
        ),
      ),
    );
  }

  // READ ONLY VIEWS

  Widget _buildReadOnlyBiodataTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _readOnlyField('Matric Number', _biodata.matricNumber),
          _readOnlyField('Surname', _biodata.surname),
          _readOnlyField('First Name', _biodata.firstName),
          _readOnlyField('Other Names', _biodata.otherNames),
          _readOnlyDateField('Date of Birth', _biodata.dateOfBirth),
          _readOnlyField('Sex', _biodata.sex),
          _readOnlyField('Marital Status', _biodata.maritalStatus),
          _readOnlyField('Nationality', _biodata.nationality),
          _readOnlyField('Place of Birth', _biodata.placeOfBirth),
          _readOnlyField('Phone Number', _biodata.phoneNumber),
          _readOnlyField('Department', _biodata.department),
          _readOnlyField('Programme', _biodata.programme),
          _readOnlyField(
              'Parent/Guardian Name', _biodata.nameOfParentOrGuardian),
          _readOnlyField(
              'Parent/Guardian Phone', _biodata.phoneNumberOfParentOrGuardian),
          _readOnlyField('Next of Kin', _biodata.nameOfNextOfKin),
          _readOnlyField('Next of Kin Phone', _biodata.phoneNumberOfNextOfKin),
        ],
      ),
    );
  }

  Widget _buildReadOnlyMedicalTestTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _readOnlyIntField('Height (m)', _medicalTest.heightMeters),
          _readOnlyIntField('Height (cm)', _medicalTest.heightCm),
          _readOnlyIntField('Weight (kg)', _medicalTest.weightKg),
          _readOnlyIntField('Weight (g)', _medicalTest.weightG),
          _readOnlyField('Blood Group', _medicalTest.bloodGroup),
          _readOnlyField('Genotype', _medicalTest.genotype),
          _readOnlyField('Blood Pressure', _medicalTest.bloodPressure),
          _readOnlyField('Heart', _medicalTest.heart),
          _readOnlyField('Hearing Left', _medicalTest.hearingLeft),
          _readOnlyField('Hearing Right', _medicalTest.hearingRight),
          _readOnlyDateField('Test Date', _medicalTest.testDate),
          _readOnlyField('Medical Officer', _medicalTest.medicalOfficerName),
          _readOnlyField('Hospital Address', _medicalTest.hospitalAddress),
          _readOnlyField('Remarks', _medicalTest.remarks),
        ],
      ),
    );
  }

  Widget _readOnlyField(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              (value == null || value.isEmpty) ? 'Not yet provided' : value,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _readOnlyIntField(String label, int? value) {
    String text = (value == null) ? 'Not yet provided' : value.toString();
    return _readOnlyField(label, text);
  }

  Widget _readOnlyDateField(String label, DateTime? value) {
    String text =
        (value == null) ? 'Not yet provided' : DateFormat.yMMMd().format(value);
    return _readOnlyField(label, text);
  }

  // EDITABLE VIEWS

  Widget _buildEditableBiodataTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _editableField('Matric Number', _editableBiodata.matricNumber, (val) {
            setState(() {
              _editableBiodata = _editableBiodata.copyWith(matricNumber: val);
            });
          }, validator: (val) {
            if (val == null || val.isEmpty) return 'Matric Number is required';
            return null;
          }),
          _editableField('Surname', _editableBiodata.surname, (val) {
            setState(() {
              _editableBiodata = _editableBiodata.copyWith(surname: val);
            });
          }, validator: (val) {
            if (val == null || val.isEmpty) return 'Surname is required';
            return null;
          }),
          _editableField('First Name', _editableBiodata.firstName, (val) {
            setState(() {
              _editableBiodata = _editableBiodata.copyWith(firstName: val);
            });
          }, validator: (val) {
            if (val == null || val.isEmpty) return 'First Name is required';
            return null;
          }),
          _editableField('Other Names', _editableBiodata.otherNames, (val) {
            setState(() {
              _editableBiodata = _editableBiodata.copyWith(otherNames: val);
            });
          }),
          _editableDateField('Date of Birth', _editableBiodata.dateOfBirth,
              (picked) {
            setState(() {
              _editableBiodata = _editableBiodata.copyWith(dateOfBirth: picked);
            });
          }),
          _editableField('Sex', _editableBiodata.sex, (val) {
            setState(() {
              _editableBiodata = _editableBiodata.copyWith(sex: val);
            });
          }),
          _editableField('Marital Status', _editableBiodata.maritalStatus,
              (val) {
            setState(() {
              _editableBiodata = _editableBiodata.copyWith(maritalStatus: val);
            });
          }),
          _editableField('Nationality', _editableBiodata.nationality, (val) {
            setState(() {
              _editableBiodata = _editableBiodata.copyWith(nationality: val);
            });
          }),
          _editableField('Place of Birth', _editableBiodata.placeOfBirth,
              (val) {
            setState(() {
              _editableBiodata = _editableBiodata.copyWith(placeOfBirth: val);
            });
          }),
          _editableField('Phone Number', _editableBiodata.phoneNumber, (val) {
            setState(() {
              _editableBiodata = _editableBiodata.copyWith(phoneNumber: val);
            });
          }),
          _editableField('Department', _editableBiodata.department, (val) {
            setState(() {
              _editableBiodata = _editableBiodata.copyWith(department: val);
            });
          }),
          _editableField('Programme', _editableBiodata.programme, (val) {
            setState(() {
              _editableBiodata = _editableBiodata.copyWith(programme: val);
            });
          }),
          _editableField(
              'Parent/Guardian Name', _editableBiodata.nameOfParentOrGuardian,
              (val) {
            setState(() {
              _editableBiodata =
                  _editableBiodata.copyWith(nameOfParentOrGuardian: val);
            });
          }),
          _editableField('Parent/Guardian Phone',
              _editableBiodata.phoneNumberOfParentOrGuardian, (val) {
            setState(() {
              _editableBiodata =
                  _editableBiodata.copyWith(phoneNumberOfParentOrGuardian: val);
            });
          }),
          _editableField('Next of Kin', _editableBiodata.nameOfNextOfKin,
              (val) {
            setState(() {
              _editableBiodata =
                  _editableBiodata.copyWith(nameOfNextOfKin: val);
            });
          }),
          _editableField(
              'Next of Kin Phone', _editableBiodata.phoneNumberOfNextOfKin,
              (val) {
            setState(() {
              _editableBiodata =
                  _editableBiodata.copyWith(phoneNumberOfNextOfKin: val);
            });
          }),
        ],
      ),
    );
  }

  Widget _buildEditableMedicalTestTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _editableIntField('Height (m)', _editableMedicalTest.heightMeters,
              (val) {
            setState(() {
              _editableMedicalTest =
                  _editableMedicalTest.copyWith(heightMeters: val);
            });
          }),
          _editableIntField('Height (cm)', _editableMedicalTest.heightCm,
              (val) {
            setState(() {
              _editableMedicalTest =
                  _editableMedicalTest.copyWith(heightCm: val);
            });
          }),
          _editableIntField('Weight (kg)', _editableMedicalTest.weightKg,
              (val) {
            setState(() {
              _editableMedicalTest =
                  _editableMedicalTest.copyWith(weightKg: val);
            });
          }),
          _editableIntField('Weight (g)', _editableMedicalTest.weightG, (val) {
            setState(() {
              _editableMedicalTest =
                  _editableMedicalTest.copyWith(weightG: val);
            });
          }),
          _editableField('Blood Group', _editableMedicalTest.bloodGroup, (val) {
            setState(() {
              _editableMedicalTest =
                  _editableMedicalTest.copyWith(bloodGroup: val);
            });
          }),
          _editableField('Genotype', _editableMedicalTest.genotype, (val) {
            setState(() {
              _editableMedicalTest =
                  _editableMedicalTest.copyWith(genotype: val);
            });
          }),
          _editableField('Blood Pressure', _editableMedicalTest.bloodPressure,
              (val) {
            setState(() {
              _editableMedicalTest =
                  _editableMedicalTest.copyWith(bloodPressure: val);
            });
          }),
          _editableField('Heart', _editableMedicalTest.heart, (val) {
            setState(() {
              _editableMedicalTest = _editableMedicalTest.copyWith(heart: val);
            });
          }),
          _editableField('Hearing Left', _editableMedicalTest.hearingLeft,
              (val) {
            setState(() {
              _editableMedicalTest =
                  _editableMedicalTest.copyWith(hearingLeft: val);
            });
          }),
          _editableField('Hearing Right', _editableMedicalTest.hearingRight,
              (val) {
            setState(() {
              _editableMedicalTest =
                  _editableMedicalTest.copyWith(hearingRight: val);
            });
          }),
          _editableDateField('Test Date', _editableMedicalTest.testDate, (val) {
            setState(() {
              _editableMedicalTest =
                  _editableMedicalTest.copyWith(testDate: val);
            });
          }),
          _editableField(
              'Medical Officer', _editableMedicalTest.medicalOfficerName,
              (val) {
            setState(() {
              _editableMedicalTest =
                  _editableMedicalTest.copyWith(medicalOfficerName: val);
            });
          }),
          _editableField(
              'Hospital Address', _editableMedicalTest.hospitalAddress, (val) {
            setState(() {
              _editableMedicalTest =
                  _editableMedicalTest.copyWith(hospitalAddress: val);
            });
          }),
          _editableField('Remarks', _editableMedicalTest.remarks, (val) {
            setState(() {
              _editableMedicalTest =
                  _editableMedicalTest.copyWith(remarks: val);
            });
          }),
        ],
      ),
    );
  }

  // Reusable Editable Text Field with validation
  Widget _editableField(
      String label, String? initialValue, ValueChanged<String> onChanged,
      {String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        initialValue: initialValue ?? '',
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        style: const TextStyle(fontSize: 16),
        keyboardType: _getKeyboardType(label),
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }

  Widget _editableIntField(
      String label, int? initialValue, ValueChanged<int?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        initialValue: initialValue?.toString() ?? '',
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 16),
        onChanged: (val) {
          int? parsed = int.tryParse(val);
          onChanged(parsed);
        },
      ),
    );
  }

  // Custom date picker widget
  Widget _editableDateField(
      String label, DateTime? value, ValueChanged<DateTime> onDatePicked) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87)),
          const SizedBox(height: 8),
          InkWell(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: value ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (picked != null) onDatePicked(picked);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                value == null
                    ? 'Not yet provided'
                    : DateFormat.yMMMd().format(value),
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Helper to pick keyboard type
  TextInputType _getKeyboardType(String label) {
    final lowerLabel = label.toLowerCase();
    if (lowerLabel.contains('phone') || lowerLabel.contains('number')) {
      return TextInputType.phone;
    } else if (lowerLabel.contains('weight') ||
        lowerLabel.contains('height') ||
        lowerLabel.contains('int') ||
        lowerLabel.contains('cm') ||
        lowerLabel.contains('kg') ||
        lowerLabel.contains('g')) {
      return TextInputType.number;
    }
    return TextInputType.text;
  }
}
