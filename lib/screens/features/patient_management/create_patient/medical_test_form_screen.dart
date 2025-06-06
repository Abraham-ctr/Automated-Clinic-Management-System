import 'package:automated_clinic_management_system/core/services/patient_service.dart';
import 'package:automated_clinic_management_system/core/utils/constants.dart';
import 'package:automated_clinic_management_system/core/utils/routes.dart';
import 'package:automated_clinic_management_system/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:automated_clinic_management_system/widgets/auth/my_button.dart';

class MedicalTestFormScreen extends StatefulWidget {
  final PatientBiodata biodata;

  const MedicalTestFormScreen({super.key, required this.biodata});

  @override
  State<MedicalTestFormScreen> createState() => _MedicalTestFormScreenState();
}

class _MedicalTestFormScreenState extends State<MedicalTestFormScreen> {
  final PatientService _patientService = PatientService();
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  late String _matricNumber;

  DateTime? _testDate;
  final TextEditingController _testDateController = TextEditingController();

  // Grouped controllers by category
  final Map<String, TextEditingController> _controllers = {
    // Vital Signs
    'heightM': TextEditingController(),
    'heightCm': TextEditingController(),
    'weightKg': TextEditingController(),
    'weightG': TextEditingController(),
    'bloodPressure': TextEditingController(),

    // Vision
    'visualAcuityWithoutRight': TextEditingController(),
    'visualAcuityWithoutLeft': TextEditingController(),
    'visualAcuityWithRight': TextEditingController(),
    'visualAcuityWithLeft': TextEditingController(),
    'eyes': TextEditingController(),

    // Hearing
    'hearingLeft': TextEditingController(),
    'hearingRight': TextEditingController(),

    // Cardiovascular
    'heart': TextEditingController(),

    // Respiratory
    'respiratorySystem': TextEditingController(),
    'pharynx': TextEditingController(),
    'lungs': TextEditingController(),

    // Gastrointestinal
    'teeth': TextEditingController(),
    'liver': TextEditingController(),
    'lymphaticGlands': TextEditingController(),
    'spleen': TextEditingController(),

    // Skin/Hernia
    'skin': TextEditingController(),
    'hernia': TextEditingController(),

    // Reflexes
    'papillaryReflex': TextEditingController(),
    'spinalReflex': TextEditingController(),

    // Urine Tests
    'urineAlbumin': TextEditingController(),
    'urineSugar': TextEditingController(),
    'urineProtein': TextEditingController(),

    // Stool Tests
    'stoolOccultBlood': TextEditingController(),
    'stoolMicroscope': TextEditingController(),
    'stoolOvaOrCyst': TextEditingController(),

    // Blood Tests
    'bloodHb': TextEditingController(),
    'bloodGroup': TextEditingController(),
    'genotype': TextEditingController(),
    'vdrlTest': TextEditingController(),

    // X-Ray
    'chestXRayFilmNo': TextEditingController(),
    'chestXRayHospital': TextEditingController(),
    'chestXRayReport': TextEditingController(),

    // Other
    'otherObservation': TextEditingController(),
    'remarks': TextEditingController(),

    // Medical Officer
    'medicalOfficerName': TextEditingController(),
    'hospitalAddress': TextEditingController(),
  };

  Future<void> _saveMedicalTest() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final medicalTest = PatientMedicalTest(
        heightMeters: int.tryParse(_controllers['heightM']!.text) ?? 0,
        heightCm: int.tryParse(_controllers['heightCm']!.text) ?? 0,
        weightKg: int.tryParse(_controllers['weightKg']!.text) ?? 0,
        weightG: int.tryParse(_controllers['weightG']!.text) ?? 0,
        visualAcuityWithoutGlassesRight:
            _controllers['visualAcuityWithoutRight']!.text,
        visualAcuityWithoutGlassesLeft:
            _controllers['visualAcuityWithoutLeft']!.text,
        visualAcuityWithGlassesRight:
            _controllers['visualAcuityWithRight']!.text,
        visualAcuityWithGlassesLeft: _controllers['visualAcuityWithLeft']!.text,
        hearingLeft: _controllers['hearingLeft']!.text,
        hearingRight: _controllers['hearingRight']!.text,
        heart: _controllers['heart']!.text,
        bloodPressure: _controllers['bloodPressure']!.text,
        eyes: _controllers['eyes']!.text,
        respiratorySystem: _controllers['respiratorySystem']!.text,
        pharynx: _controllers['pharynx']!.text,
        lungs: _controllers['lungs']!.text,
        teeth: _controllers['teeth']!.text,
        liver: _controllers['liver']!.text,
        lymphaticGlands: _controllers['lymphaticGlands']!.text,
        spleen: _controllers['spleen']!.text,
        skin: _controllers['skin']!.text,
        hernia: _controllers['hernia']!.text,
        papillaryReflex: _controllers['papillaryReflex']!.text,
        spinalReflex: _controllers['spinalReflex']!.text,
        urineAlbumin: _controllers['urineAlbumin']!.text,
        urineSugar: _controllers['urineSugar']!.text,
        urineProtein: _controllers['urineProtein']!.text,
        stoolOccultBlood: _controllers['stoolOccultBlood']!.text,
        stoolMicroscope: _controllers['stoolMicroscope']!.text,
        stoolOvaOrCyst: _controllers['stoolOvaOrCyst']!.text,
        bloodHb: _controllers['bloodHb']!.text,
        bloodGroup: _controllers['bloodGroup']!.text,
        genotype: _controllers['genotype']!.text,
        vdrlTest: _controllers['vdrlTest']!.text,
        chestXRayFilmNo: _controllers['chestXRayFilmNo']!.text,
        chestXRayHospital: _controllers['chestXRayHospital']!.text,
        chestXRayReport: _controllers['chestXRayReport']!.text,
        otherObservation: _controllers['otherObservation']!.text,
        remarks: _controllers['remarks']!.text,
        testDate: _testDate!,
        medicalOfficerName: _controllers['medicalOfficerName']!.text,
        hospitalAddress: _controllers['hospitalAddress']!.text,
      );

      await _patientService.saveMedicalTest(_matricNumber, medicalTest);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Medical test saved successfully!')),
      );

      // Clear form
      _formKey.currentState!.reset();
      _testDateController.clear();
      _testDate = null;
      for (var controller in _controllers.values) {
        controller.clear();
      }

      // Navigate to view patients screen
      Navigator.pushReplacementNamed(context, AppRoutes.viewPatients);

      _formKey.currentState!.reset();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving medical test: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _matricNumber = widget.biodata.matricNumber;
  }

  @override
  void dispose() {
    _testDateController.dispose();
    // Dispose all controllers
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppConstants.priColor,
              onPrimary: Colors.white,
              onSurface: AppConstants.darkGreyColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppConstants.priColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _testDate) {
      setState(() => _testDate = picked);
      _testDateController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  // ================ REUSABLE WIDGET BUILDERS ================
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppConstants.priColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSubSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppConstants.darkGreyColor,
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String controllerKey,
    required String label,
    IconData? icon,
    TextInputType? keyboardType,
    bool required = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: _controllers[controllerKey],
        decoration: InputDecoration(
          labelText: '$label${required ? ' *' : ''}',
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
          prefixIcon: icon != null
              ? Icon(icon, color: AppConstants.darkGreyColor)
              : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
        keyboardType: keyboardType,
        validator: required
            ? (value) => value!.isEmpty ? 'Required field' : null
            : null,
        maxLines: maxLines,
      ),
    );
  }

  Widget _buildNumberField({
    required String controllerKey,
    required String label,
    bool required = false,
  }) {
    return _buildTextFormField(
      controllerKey: controllerKey,
      label: label,
      required: required,
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildDatePickerField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        readOnly: true,
        controller: _testDateController,
        decoration: InputDecoration(
          labelText: 'Test Date *',
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
          prefixIcon: const Icon(Icons.calendar_today,
              color: AppConstants.darkGreyColor),
          suffixIcon: IconButton(
            icon: const Icon(Icons.edit_outlined,
                color: AppConstants.darkGreyColor),
            onPressed: () => _selectDate(context),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
        onTap: () => _selectDate(context),
        validator: (value) =>
            _testDate == null ? 'Please select test date' : null,
      ),
    );
  }

  Widget _buildRowFieldPair(
      String key1, String label1, String key2, String label2,
      {bool required = false}) {
    return Row(
      children: [
        Expanded(
          child: _buildTextFormField(
            controllerKey: key1,
            label: label1,
            required: required,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildTextFormField(
            controllerKey: key2,
            label: label2,
            required: required,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Examination'),
        centerTitle: true,
        backgroundColor: AppConstants.priColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: AppConstants.lightGreyColor,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Patient Info Card
                Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.biodata.surname}, ${widget.biodata.firstName} ${widget.biodata.otherNames}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.darkGreyColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Matric: ${widget.biodata.matricNumber}'),
                        Text('Department: ${widget.biodata.department}'),
                      ],
                    ),
                  ),
                ),

                // Test Date Picker
                _buildDatePickerField(),

                // ======== SECTION 1: VITAL SIGNS ========
                _buildSectionHeader('Vital Signs'),
                Row(
                  children: [
                    Expanded(
                      child: _buildNumberField(
                        controllerKey: 'heightM',
                        label: 'Height (meters)',
                        required: true,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildNumberField(
                        controllerKey: 'heightCm',
                        label: 'Height (cm)',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildNumberField(
                        controllerKey: 'weightKg',
                        label: 'Weight (kg)',
                        required: true,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildNumberField(
                        controllerKey: 'weightG',
                        label: 'Weight (grams)',
                      ),
                    ),
                  ],
                ),
                _buildTextFormField(
                  controllerKey: 'bloodPressure',
                  label: 'Blood Pressure (mmHg)',
                  required: true,
                  icon: Icons.monitor_heart_outlined,
                ),

                // ======== SECTION 2: VISION TESTS ========
                _buildSectionHeader('Vision Tests'),
                _buildSubSectionHeader('Without Glasses'),
                _buildRowFieldPair(
                  'visualAcuityWithoutRight',
                  'Right Eye',
                  'visualAcuityWithoutLeft',
                  'Left Eye',
                ),
                _buildSubSectionHeader('With Glasses'),
                _buildRowFieldPair(
                  'visualAcuityWithRight',
                  'Right Eye',
                  'visualAcuityWithLeft',
                  'Left Eye',
                ),
                _buildTextFormField(
                  controllerKey: 'eyes',
                  label: 'Eye Examination Notes',
                  icon: Icons.remove_red_eye,
                  maxLines: 2,
                ),

                // ======== SECTION 3: HEARING TESTS ========
                _buildSectionHeader('Hearing Tests'),
                _buildRowFieldPair(
                  'hearingLeft',
                  'Left Ear',
                  'hearingRight',
                  'Right Ear',
                ),

                // ======== SECTION 4: CARDIOVASCULAR ========
                _buildSectionHeader('Cardiovascular System'),
                _buildTextFormField(
                  controllerKey: 'heart',
                  label: 'Heart Examination',
                  icon: Icons.favorite_border,
                ),

                // ======== SECTION 5: RESPIRATORY ========
                _buildSectionHeader('Respiratory System'),
                _buildTextFormField(
                  controllerKey: 'respiratorySystem',
                  label: 'Respiratory System',
                  icon: Icons.air,
                ),
                _buildTextFormField(
                  controllerKey: 'pharynx',
                  label: 'Pharynx',
                ),
                _buildTextFormField(
                  controllerKey: 'lungs',
                  label: 'Lungs',
                ),

                // ======== SECTION 6: GASTROINTESTINAL ========
                _buildSectionHeader('Gastrointestinal System'),
                _buildTextFormField(
                  controllerKey: 'teeth',
                  label: 'Teeth',
                ),
                _buildTextFormField(
                  controllerKey: 'liver',
                  label: 'Liver',
                ),
                _buildTextFormField(
                  controllerKey: 'lymphaticGlands',
                  label: 'Lymphatic Glands',
                ),
                _buildTextFormField(
                  controllerKey: 'spleen',
                  label: 'Spleen',
                ),

                // ======== SECTION 7: SKIN & HERNIA ========
                _buildSectionHeader('Skin & Hernia'),
                _buildTextFormField(
                  controllerKey: 'skin',
                  label: 'Skin Condition',
                ),
                _buildTextFormField(
                  controllerKey: 'hernia',
                  label: 'Hernia Check',
                ),

                // ======== SECTION 8: NEUROLOGICAL REFLEXES ========
                _buildSectionHeader('Neurological Reflexes'),
                _buildRowFieldPair(
                  'papillaryReflex',
                  'Papillary Reflex',
                  'spinalReflex',
                  'Spinal Reflex',
                ),

                // ======== SECTION 9: LABORATORY TESTS ========
                _buildSectionHeader('Laboratory Tests'),
                _buildSubSectionHeader('Urine Analysis'),
                _buildTextFormField(
                  controllerKey: 'urineAlbumin',
                  label: 'Albumin',
                ),
                _buildTextFormField(
                  controllerKey: 'urineSugar',
                  label: 'Sugar',
                ),
                _buildTextFormField(
                  controllerKey: 'urineProtein',
                  label: 'Protein',
                ),

                _buildSubSectionHeader('Stool Analysis'),
                _buildTextFormField(
                  controllerKey: 'stoolOccultBlood',
                  label: 'Occult Blood',
                ),
                _buildTextFormField(
                  controllerKey: 'stoolMicroscope',
                  label: 'Microscopy',
                ),
                _buildTextFormField(
                  controllerKey: 'stoolOvaOrCyst',
                  label: 'Ova/Cyst',
                ),

                _buildSubSectionHeader('Blood Tests'),
                _buildTextFormField(
                  controllerKey: 'bloodHb',
                  label: 'HB Level',
                ),
                _buildRowFieldPair(
                  'bloodGroup',
                  'Blood Group',
                  'genotype',
                  'Genotype',
                ),
                _buildTextFormField(
                  controllerKey: 'vdrlTest',
                  label: 'VDRL Test',
                ),

                // ======== SECTION 10: CHEST X-RAY ========
                _buildSectionHeader('Chest X-Ray'),
                _buildTextFormField(
                  controllerKey: 'chestXRayFilmNo',
                  label: 'Film Number',
                ),
                _buildTextFormField(
                  controllerKey: 'chestXRayHospital',
                  label: 'Hospital/Clinic',
                ),
                _buildTextFormField(
                  controllerKey: 'chestXRayReport',
                  label: 'Report',
                  maxLines: 3,
                ),

                // ======== SECTION 11: OBSERVATIONS ========
                _buildSectionHeader('Observations & Remarks'),
                _buildTextFormField(
                  controllerKey: 'otherObservation',
                  label: 'Other Observations',
                  maxLines: 3,
                ),
                _buildTextFormField(
                  controllerKey: 'remarks',
                  label: 'Remarks',
                  maxLines: 3,
                ),

                // ======== SECTION 12: MEDICAL OFFICER ========
                _buildSectionHeader('Medical Officer'),
                _buildTextFormField(
                  controllerKey: 'medicalOfficerName',
                  label: 'Medical Officer Name',
                  required: true,
                  icon: Icons.medical_services,
                ),
                _buildTextFormField(
                  controllerKey: 'hospitalAddress',
                  label: 'Hospital Address',
                  required: true,
                  icon: Icons.location_on,
                  maxLines: 2,
                ),

                // Submit Button
                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: MyButton(
                      text: 'Save Medical Data',
                      onPressed: _saveMedicalTest,
                      isPrimary: true,
                      isLoading: _isSaving,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
