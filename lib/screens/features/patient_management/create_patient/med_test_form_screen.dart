import 'package:automated_clinic_management_system/core/services/patient_service.dart';
import 'package:automated_clinic_management_system/core/utils/constants.dart';
import 'package:automated_clinic_management_system/core/utils/routes.dart';
import 'package:automated_clinic_management_system/models/patient.dart';
import 'package:automated_clinic_management_system/widgets/auth/my_button.dart';
import 'package:automated_clinic_management_system/widgets/form_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MedTestFormScreen extends StatefulWidget {
  // final PatientBiodata biodata;

  const MedTestFormScreen({super.key, });

  @override
  State<MedTestFormScreen> createState() => _MedTestFormScreenState();
}

class _MedTestFormScreenState extends State<MedTestFormScreen> {
  // variables
  final PatientService _patientService = PatientService();
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;
  late String _matricNumber;
  DateTime? _testDate;

  final List<String> _hearingOptions = [
    'Normal',
    'Impaired',
    'Deaf',
  ];
  final List<String> _heartOptions = [
    'Normal',
    'Murmur',
    'Irregular beat',
    'Tachycardia',
    'Bradycardia',
  ];
  final List<String> _respiratoryOptions = [
    'Clear',
    'Wheezing',
    'Crackles',
    'Reduced breath sounds',
    'Bronchial breathing',
  ];
  final List<String> _pharynxOptions = [
    'Normal',
    'Congested',
    'Inflamed',
    'Tonsillitis',
  ];
  final List<String> _lungsOptions = [
    'Clear',
    'Crepitations',
    'Rhonchi',
    'Decreased air entry',
  ];
  final List<String> _teethOptions = [
    'Healthy',
    'Caries',
    'Missing teeth',
    'Malalignment',
  ];
  final List<String> _lymphaticOptions = [
    'Not enlarged',
    'Enlarged - cervical',
    'Enlarged - axillary',
    'Enlarged - inguinal',
  ];
  final List<String> _spleenOptions = [
    'Not palpable',
    'Enlarged',
    'Tender',
  ];
  final List<String> _skinOptions = [
    'Normal',
    'Rashes',
    'Scars',
    'Ulcers',
    'Pallor',
    'Jaundice',
  ];
  final List<String> _herniaOptions = [
    'No hernia',
    'Inguinal',
    'Umbilical',
    'Incisional',
  ];
  final List<String> _papillaryOptions = [
    'Normal',
    'Sluggish',
    'Absent',
  ];
  final List<String> _spinalOptions = [
    'Normal',
    'Hyperreflexia',
    'Hyporeflexia',
    'Absent',
  ];
  final List<String> _urineOptions = [
    'Negative',
    'Trace',
    '+',
    '++',
    '+++',
  ];
  final List<String> _stoolTestOptions = [
    'Negative',
    'Positive',
    'Few seen',
    'Many seen',
    'None seen',
  ];
  final List<String> _bloodGroupOptions = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];
  final List<String> _genotypeOptions = [
    'AA',
    'AS',
    'SS',
    'AC',
    'SC',
  ];
  final List<String> _vdrlOptions = [
    'Non-reactive',
    'Reactive',
    'Indeterminate',
  ];
  final List<String> _hbOptions = [
    '<10 g/dL',
    '10–12 g/dL',
    '12–15 g/dL',
    '>15 g/dL',
  ];

  // Grouped controllers by category
  final TextEditingController _testDateController = TextEditingController();

  Map<String, TextEditingController> _controllers = {
    // SECTION 1: Vital Signs
    'heightM': TextEditingController(),
    'heightCm': TextEditingController(),
    'weightKg': TextEditingController(),
    'weightG': TextEditingController(),
    'bloodPressure': TextEditingController(),

    // SECTION 2: Vision
    'visualAcuityWithoutRight': TextEditingController(),
    'visualAcuityWithoutLeft': TextEditingController(),
    'visualAcuityWithRight': TextEditingController(),
    'visualAcuityWithLeft': TextEditingController(),
    'eyes': TextEditingController(),
    'eyesRemarks': TextEditingController(),

    // SECTION 3: Hearing
    'hearingLeft': TextEditingController(),
    'hearingRight': TextEditingController(),
    'hearingLeftRemarks': TextEditingController(),
    'hearingRightRemarks': TextEditingController(),

    // SECTION 4: Cardiovascular
    'heart': TextEditingController(),
    'heartRemarks': TextEditingController(),

    // SECTION 5: Respiratory System
    'respiratorySystem': TextEditingController(),
    'respiratorySystemRemarks': TextEditingController(),

    // SECTION 6: ENT & Lungs
    'pharynx': TextEditingController(),
    'pharynxRemarks': TextEditingController(),
    'lungs': TextEditingController(),
    'lungsRemarks': TextEditingController(),

    // SECTION 7: Gastrointestinal
    'teeth': TextEditingController(),
    'teethRemarks': TextEditingController(),
    'liver': TextEditingController(),
    'liverRemarks': TextEditingController(),
    'lymphaticGlands': TextEditingController(),
    'lymphaticGlandsRemarks': TextEditingController(),
    'spleen': TextEditingController(),
    'spleenRemarks': TextEditingController(),

    // SECTION 8: Skin & Hernia
    'skin': TextEditingController(),
    'skinRemarks': TextEditingController(),
    'hernia': TextEditingController(),
    'herniaRemarks': TextEditingController(),

    // SECTION 9: Reflexes
    'papillaryReflex': TextEditingController(),
    'papillaryReflexRemarks': TextEditingController(),
    'spinalReflex': TextEditingController(),
    'spinalReflexRemarks': TextEditingController(),

    // SECTION 10: Urine Tests
    'urineAlbumin': TextEditingController(),
    'urineAlbuminRemarks': TextEditingController(),
    'urineSugar': TextEditingController(),
    'urineSugarRemarks': TextEditingController(),
    'urineProtein': TextEditingController(),
    'urineProteinRemarks': TextEditingController(),

    // SECTION 11: Stool Tests
    'stoolOccultBlood': TextEditingController(),
    'stoolOccultBloodRemarks': TextEditingController(),
    'stoolMicroscope': TextEditingController(),
    'stoolMicroscopeRemarks': TextEditingController(),
    'stoolOvaOrCyst': TextEditingController(),
    'stoolOvaOrCystRemarks': TextEditingController(),

    // SECTION 12: Blood Tests
    'bloodHb': TextEditingController(),
    'bloodHbRemarks': TextEditingController(),
    'bloodGroup': TextEditingController(),
    'bloodGroupRemarks': TextEditingController(),
    'genotype': TextEditingController(),
    'genotypeRemarks': TextEditingController(),
    'vdrlTest': TextEditingController(),
    'vdrlTestRemarks': TextEditingController(),

    // SECTION 13: Chest X-Ray
    'chestXRayFilmNo': TextEditingController(),
    'chestXRayHospital': TextEditingController(),
    'chestXRayReport': TextEditingController(),

    // SECTION 14: Other
    'otherObservation': TextEditingController(),
    'remarks': TextEditingController(),

    // SECTION 15: Medical Officer
    'medicalOfficerName': TextEditingController(),
    'hospitalAddress': TextEditingController(),
  };

  @override
  void initState() {
    super.initState();
    // _matricNumber = widget.biodata.matricNumber;
    _controllers = {
      // SECTION 1: Vital Signs
      'heightM': TextEditingController(),
      'heightCm': TextEditingController(),
      'weightKg': TextEditingController(),
      'weightG': TextEditingController(),
      'bloodPressure': TextEditingController(),

      // SECTION 2: Vision
      'visualAcuityWithoutRight': TextEditingController(),
      'visualAcuityWithoutLeft': TextEditingController(),
      'visualAcuityWithRight': TextEditingController(),
      'visualAcuityWithLeft': TextEditingController(),
      'eyes': TextEditingController(),
      'eyesRemarks': TextEditingController(),

      // SECTION 3: Hearing
      'hearingLeft': TextEditingController(),
      'hearingRight': TextEditingController(),
      'hearingLeftRemarks': TextEditingController(),
      'hearingRightRemarks': TextEditingController(),

      // SECTION 4: Cardiovascular
      'heart': TextEditingController(),
      'heartRemarks': TextEditingController(),

      // SECTION 5: Respiratory System
      'respiratorySystem': TextEditingController(),
      'respiratorySystemRemarks': TextEditingController(),

      // SECTION 6: ENT & Lungs
      'pharynx': TextEditingController(),
      'pharynxRemarks': TextEditingController(),
      'lungs': TextEditingController(),
      'lungsRemarks': TextEditingController(),

      // SECTION 7: Gastrointestinal
      'teeth': TextEditingController(),
      'teethRemarks': TextEditingController(),
      'liver': TextEditingController(),
      'liverRemarks': TextEditingController(),
      'lymphaticGlands': TextEditingController(),
      'lymphaticGlandsRemarks': TextEditingController(),
      'spleen': TextEditingController(),
      'spleenRemarks': TextEditingController(),

      // SECTION 8: Skin & Hernia
      'skin': TextEditingController(),
      'skinRemarks': TextEditingController(),
      'hernia': TextEditingController(),
      'herniaRemarks': TextEditingController(),

      // SECTION 9: Reflexes
      'papillaryReflex': TextEditingController(),
      'papillaryReflexRemarks': TextEditingController(),
      'spinalReflex': TextEditingController(),
      'spinalReflexRemarks': TextEditingController(),

      // SECTION 10: Urine Tests
      'urineAlbumin': TextEditingController(),
      'urineAlbuminRemarks': TextEditingController(),
      'urineSugar': TextEditingController(),
      'urineSugarRemarks': TextEditingController(),
      'urineProtein': TextEditingController(),
      'urineProteinRemarks': TextEditingController(),

      // SECTION 11: Stool Tests
      'stoolOccultBlood': TextEditingController(),
      'stoolOccultBloodRemarks': TextEditingController(),
      'stoolMicroscope': TextEditingController(),
      'stoolMicroscopeRemarks': TextEditingController(),
      'stoolOvaOrCyst': TextEditingController(),
      'stoolOvaOrCystRemarks': TextEditingController(),

      // SECTION 12: Blood Tests
      'bloodHb': TextEditingController(),
      'bloodHbRemarks': TextEditingController(),
      'bloodGroup': TextEditingController(),
      'bloodGroupRemarks': TextEditingController(),
      'genotype': TextEditingController(),
      'genotypeRemarks': TextEditingController(),
      'vdrlTest': TextEditingController(),
      'vdrlTestRemarks': TextEditingController(),

      // SECTION 13: Chest X-Ray
      'chestXRayFilmNo': TextEditingController(),
      'chestXRayHospital': TextEditingController(),
      'chestXRayReport': TextEditingController(),

      // SECTION 14: Other
      'otherObservation': TextEditingController(),
      'remarks': TextEditingController(),

      // SECTION 15: Medical Officer
      'medicalOfficerName': TextEditingController(),
      'hospitalAddress': TextEditingController(),
    };
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
      initialDate:
          _testDate ?? DateTime.now(), // Use existing value if available
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

    if (picked != null) {
      setState(() {
        _testDate = picked;
        _testDateController.text =
            DateFormat('dd/MM/yyyy').format(picked); // or d MMMM yyyy
      });
    }
  }

  Future<void> _saveMedicalTest() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    try {
      

      // await _patientService.saveMedicalTest(_matricNumber, medicalTest);

      if (!mounted) return;
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30.0, left: 30, right: 30, bottom: 10),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Material(
              elevation: 10,
              child: Scrollbar(
                interactive: true,
                trackVisibility: true,
                child: SingleChildScrollView(
                  child: Form(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          // borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormHeader(
                            text: "Medical Tests",
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.dashboard);
                            },
                          ),

                          // Patient Info Card
                          // Card(
                          //   elevation: 2,
                          //   margin: const EdgeInsets.only(bottom: 20),
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10),
                          //   ),
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(16),
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Text(
                          //           '${widget.biodata.surname}, ${widget.biodata.firstName} ${widget.biodata.otherNames}',
                          //           style: const TextStyle(
                          //             fontSize: 18,
                          //             fontWeight: FontWeight.bold,
                          //             color: AppConstants.darkGreyColor,
                          //           ),
                          //         ),
                          //         const SizedBox(height: 8),
                          //         Text(
                          //             'Matric: ${widget.biodata.matricNumber}'),
                          //         Text(
                          //             'Department: ${widget.biodata.department}'),
                          //       ],
                          //     ),
                          //   ),
                          // ),

                          // Test Date Picker
                          _buildDatePickerField(),

                          // ======== SECTION 1: VITAL SIGNS ========
                          _buildSectionHeader('Vital Signs'),
                          Row(
                            children: [
                              Expanded(
                                child: _buildNumberField(
                                  controllerKey: 'heightM',
                                  label: 'Height',
                                  unitSuffix: 'm',
                                  required: true,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildNumberField(
                                  controllerKey: 'heightCm',
                                  label: 'Height',
                                  unitSuffix: 'cm',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: _buildNumberField(
                                  controllerKey: 'weightKg',
                                  label: 'Weight',
                                  unitSuffix: 'kg',
                                  required: true,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildNumberField(
                                  controllerKey: 'weightG',
                                  label: 'Weight',
                                  unitSuffix: 'g',
                                ),
                              ),
                            ],
                          ),

                          _buildSubSectionHeader('Blood Pressure'),
                          Row(
                            children: [
                              Expanded(
                                child: _buildNumberField(
                                    controllerKey: 'systolic',
                                    label: 'Systolic',
                                    required: true,
                                    unitSuffix: "mmHg"),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildNumberField(
                                    controllerKey: 'diastolic',
                                    label: 'Diastolic',
                                    required: true,
                                    unitSuffix: "mmHg"),
                              ),
                            ],
                          ),

                          // ======== SECTION 2: VISION TESTS ========
                          // Vision Tests - Without Glasses
                          _buildSectionHeader('Vision Tests'),
                          _buildSubSectionHeader('Without Glasses'),
                          Row(
                            children: [
                              Expanded(
                                child: _buildVisionField(
                                  controllerKey: 'visualAcuityWithoutRight',
                                  label: 'Right Eye',
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildVisionField(
                                  controllerKey: 'visualAcuityWithoutLeft',
                                  label: 'Left Eye',
                                ),
                              ),
                            ],
                          ),

                          // Vision Tests - With Glasses
                          _buildSubSectionHeader('With Glasses'),
                          Row(
                            children: [
                              Expanded(
                                child: _buildVisionField(
                                  controllerKey: 'visualAcuityWithRight',
                                  label: 'Right Eye',
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildVisionField(
                                  controllerKey: 'visualAcuityWithLeft',
                                  label: 'Left Eye',
                                ),
                              ),
                            ],
                          ),

                          // ======== SECTION 3: HEARING TESTS ========
                          _buildSectionHeader('Hearing Test'),
                          Row(
                            children: [
                              Expanded(
                                child: buildDropdownWithRemarks(
                                  controllerKey: 'hearingLeft',
                                  remarksControllerKey: 'hearingLeftRemarks',
                                  label: 'Left Ear',
                                  options: _hearingOptions,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: buildDropdownWithRemarks(
                                  controllerKey: 'hearingRight',
                                  remarksControllerKey: 'hearingRightRemarks',
                                  label: 'Right Ear',
                                  options: _hearingOptions,
                                ),
                              ),
                            ],
                          ),

                          // ======== SECTION 4: CARDIOVASCULAR ========
                          _buildSectionHeader('Cardiovascular System'),
                          buildDropdownWithRemarks(
                            controllerKey: 'heart',
                            remarksControllerKey: 'heartRemarks',
                            label: 'Heart',
                            options: _heartOptions,
                          ),

                          // ======== SECTION 5: RESPIRATORY ========
                          _buildSectionHeader('Respiratory System'),
                          Row(
                            children: [
                              Expanded(
                                child: buildDropdownWithRemarks(
                                  controllerKey: 'respiratorySystem',
                                  remarksControllerKey:
                                      'respiratorySystemRemarks',
                                  label: 'Respiratory System',
                                  options: _respiratoryOptions,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: buildDropdownWithRemarks(
                                  controllerKey: 'pharynx',
                                  remarksControllerKey: 'pharynxRemarks',
                                  label: 'Pharynx',
                                  options: _pharynxOptions,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: buildDropdownWithRemarks(
                                  controllerKey: 'lungs',
                                  remarksControllerKey: 'lungsRemarks',
                                  label: 'Lungs',
                                  options: _lungsOptions,
                                ),
                              ),
                            ],
                          ),

                          // ======== SECTION 6: GASTROINTESTINAL ========
                          _buildSectionHeader('Gastrointestinal System'),
                          Row(
                            children: [
                              Expanded(
                                child: buildDropdownWithRemarks(
                                  controllerKey: 'teeth',
                                  remarksControllerKey: 'teethRemarks',
                                  label: 'Teeth',
                                  options: _teethOptions,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: buildDropdownWithRemarks(
                                  controllerKey: 'lymphaticGlands',
                                  remarksControllerKey:
                                      'lymphaticGlandsRemarks',
                                  label: 'Lymphatic Glands',
                                  options: _lymphaticOptions,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: buildDropdownWithRemarks(
                                  controllerKey: 'spleen',
                                  remarksControllerKey: 'spleenRemarks',
                                  label: 'Spleen',
                                  options: _spleenOptions,
                                ),
                              ),
                            ],
                          ),

                          // ======== SECTION 7: SKIN & HERNIA ========
                          _buildSectionHeader('Skin & Hernia'),
                          Row(
                            children: [
                              Expanded(
                                child: buildDropdownWithRemarks(
                                  controllerKey: 'skin',
                                  remarksControllerKey: 'skinRemarks',
                                  label: 'Skin Condition',
                                  options: _skinOptions,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: buildDropdownWithRemarks(
                                  controllerKey: 'hernia',
                                  remarksControllerKey: 'herniaRemarks',
                                  label: 'Hernia Check',
                                  options: _herniaOptions,
                                ),
                              ),
                            ],
                          ),

                          // ======== SECTION 8: NEUROLOGICAL REFLEXES ========
                          _buildSectionHeader('Neurological Reflexes'),
                          Row(
                            children: [
                              Expanded(
                                child: buildDropdownWithRemarks(
                                  controllerKey: 'papillaryReflex',
                                  remarksControllerKey:
                                      'papillaryReflexRemarks',
                                  label: 'Papillary Reflex',
                                  options: _papillaryOptions,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: buildDropdownWithRemarks(
                                  controllerKey: 'spinalReflex',
                                  remarksControllerKey: 'spinalReflexRemarks',
                                  label: 'Spinal Reflex',
                                  options: _spinalOptions,
                                ),
                              ),
                            ],
                          ),

                          // ======== SECTION 9: LABORATORY TESTS ========
                          _buildSectionHeader('Laboratory Tests'),
                          _buildSubSectionHeader('Urine Analysis'),
                          Row(
                            children: [
                              Expanded(
                                child: buildDropdownWithRemarks(
                                  controllerKey: 'urineAlbumin',
                                  remarksControllerKey: 'urineAlbuminRemarks',
                                  label: 'Urine Albumin',
                                  options: _urineOptions,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: buildDropdownWithRemarks(
                                  controllerKey: 'urineSugar',
                                  remarksControllerKey: 'urineSugarRemarks',
                                  label: 'Urine Sugar',
                                  options: _urineOptions,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: buildDropdownWithRemarks(
                                  controllerKey: 'urineProtein',
                                  remarksControllerKey: 'urineProteinRemarks',
                                  label: 'Urine Protein',
                                  options: _urineOptions,
                                ),
                              ),
                            ],
                          ),

                          _buildSubSectionHeader('Stool Analysis'),
                          Row(
                            children: [
                              Expanded(
                                child: buildDropdownWithRemarks(
                                  controllerKey: 'stoolOccultBlood',
                                  remarksControllerKey:
                                      'stoolOccultBloodRemarks',
                                  label: 'Stool Occult Blood',
                                  options: _stoolTestOptions,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: buildDropdownWithRemarks(
                                  controllerKey: 'stoolMicroscope',
                                  remarksControllerKey:
                                      'stoolMicroscopeRemarks',
                                  label: 'Stool Microscopy',
                                  options: _stoolTestOptions,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: buildDropdownWithRemarks(
                                  controllerKey: 'stoolOvaOrCyst',
                                  remarksControllerKey: 'stoolOvaOrCystRemarks',
                                  label: 'Stool Ova or Cyst',
                                  options: _stoolTestOptions,
                                ),
                              ),
                            ],
                          ),

                          _buildSubSectionHeader('Blood Tests'),
                          Row(
                            children: [
                              Expanded(
                                child: buildDropdownWithRemarks(
                                  controllerKey: 'bloodHb',
                                  remarksControllerKey: 'bloodHbRemarks',
                                  label: 'Haemoglobin Level (Hb)',
                                  options: _hbOptions,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: buildDropdownWithRemarks(
                                  controllerKey: 'vdrlTest',
                                  remarksControllerKey: 'vdrlTestRemarks',
                                  label: 'VDRL Test',
                                  options: _vdrlOptions,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: buildDropdownWithRemarks(
                                  controllerKey: 'bloodGroup',
                                  remarksControllerKey: 'bloodGroupRemarks',
                                  label: 'Blood Group',
                                  options: _bloodGroupOptions,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: buildDropdownWithRemarks(
                                  controllerKey: 'genotype',
                                  remarksControllerKey: 'genotypeRemarks',
                                  label: 'Genotype',
                                  options: _genotypeOptions,
                                ),
                              ),
                            ],
                          ),

                          // ======== SECTION 10: CHEST X-RAY ========
                          _buildSectionHeader('Chest X-Ray'),
                          _buildTextField(
                            controllerKey: 'chestXRayFilmNo',
                            label: 'Chest X-Ray Film No',
                          ),
                          _buildTextField(
                            controllerKey: 'chestXRayHospital',
                            label: 'Chest X-Ray Hospital',
                          ),
                          _buildTextField(
                            controllerKey: 'chestXRayReport',
                            label: 'Chest X-Ray Report',
                            maxLines: 3,
                          ),

                          // ======== SECTION 11: OBSERVATIONS ========
                          _buildSectionHeader('Observations & Remarks'),
                          _buildTextField(
                            controllerKey: 'otherObservation',
                            label: 'Other Observation',
                            maxLines: 3,
                          ),
                          _buildTextField(
                            controllerKey: 'remarks',
                            label: 'Final Remarks',
                            maxLines: 4,
                          ),

                          // ======== SECTION 12: MEDICAL OFFICER ========
                          _buildSectionHeader('Medical Officer'),
                          _buildTextField(
                            controllerKey: 'medicalOfficerName',
                            label: 'Medical Officer Name',
                            required: true,
                          ),
                          _buildTextField(
                            controllerKey: 'hospitalAddress',
                            label: 'Hospital Address',
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDatePickerField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        readOnly: true, // Prevent keyboard
        controller: _testDateController,
        decoration: InputDecoration(
          labelText: 'Test Date *', // ✅ Custom label
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
            borderSide:
                const BorderSide(color: AppConstants.priColor, width: 2),
          ),
          filled: true,
          fillColor: AppConstants.whiteColor,
          prefixIcon: const Icon(
            Icons.calendar_today,
            color: AppConstants.darkGreyColor,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
        onTap: () => _selectDate(context), // ✅ Tap to pick date
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please select test date'; // ✅ Validation
          }
          return null;
        },
      ),
    );
  }

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

  Widget _buildNumberField({
    required String controllerKey,
    required String label,
    bool required = false,
    String? unitSuffix, // Optional unit suffix like "kg", "cm"
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: _controllers[controllerKey],
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(
              RegExp(r'^\d+\.?\d{0,2}')), // allows 2 decimal places
        ],
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
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
          suffixText: unitSuffix,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
        validator: (value) {
          if (required && (value == null || value.trim().isEmpty)) {
            return 'This field is required';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildVisionField({
    required String controllerKey,
    required String label,
  }) {
    return TextFormField(
      controller: _controllers[controllerKey],
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d{0,2}/?\d{0,2}$')),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }
        if (!RegExp(r'^\d{1,2}/\d{1,2}$').hasMatch(value)) {
          return 'Use format like 6/6';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: 'e.g. 6/6',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: AppConstants.whiteColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
      ),
    );
  }

  Widget buildDropdownWithRemarks({
    required String controllerKey,
    required String remarksControllerKey,
    required String label,
    required List<String> options,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        final selectedValue = _controllers[controllerKey]?.text;
        final isOtherSelected = selectedValue == 'Other';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: options.contains(selectedValue) ? selectedValue : null,
              items: [
                ...options.map((val) => DropdownMenuItem(
                      value: val,
                      child: Text(val),
                    )),
                const DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              onChanged: (val) {
                setState(() {
                  _controllers[controllerKey]?.text = val ?? '';
                  if (val != 'Other') {
                    _controllers[remarksControllerKey]?.clear();
                  }
                });
              },
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: AppConstants.whiteColor,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
              ),
              validator: (value) {
                final textValue = _controllers[controllerKey]?.text ?? '';
                if (textValue.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            if (isOtherSelected) const SizedBox(height: 10),
            if (isOtherSelected)
              TextFormField(
                controller: _controllers[remarksControllerKey],
                maxLines: 3,
                minLines: 2,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: '$label Remarks',
                  hintText: 'Please specify details',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: AppConstants.whiteColor,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                ),
                validator: (value) {
                  if ((value == null || value.trim().isEmpty)) {
                    return 'Please provide remarks for "Other"';
                  }
                  return null;
                },
              ),
          ],
        );
      },
    );
  }

  _buildTextField({
    required String controllerKey,
    required String label,
    int maxLines = 1,
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: _controllers[controllerKey],
        keyboardType: TextInputType.text,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          labelStyle: const TextStyle(color: AppConstants.darkGreyColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: AppConstants.whiteColor,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
        ),
        validator: (value) {
          if (required && (value == null || value.trim().isEmpty)) {
            return 'This field is required';
          }
          return null;
        },
      ),
    );
  }
}
