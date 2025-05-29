import 'package:automated_clinic_management_system/core/services/patient_service.dart';
import 'package:automated_clinic_management_system/widgets/auth/my_button.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/blood_group_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/date_field.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/eyes_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/genotype_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/hearing_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/form2_patient_textfield.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/heart_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/hernia_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/hospital_address_field.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/liver_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/lungs.dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/lymphatic_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/medical_officer_field.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/microscope_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/occult_blood_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/other_observation_field.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/ova_or_cyst_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/papillary_reflex_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/pharynx_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/remarks_field.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/respiratory_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/skin_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/spinal_reflex_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/spleen_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/teeth_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/urine_albumin_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/urine_protein_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/urine_sugar_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/vdrl_test_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/sub_app_bar.dart';
import 'package:flutter/material.dart';

class MedicalFormPart2 extends StatefulWidget {
  final Map<String, dynamic> formData;
  const MedicalFormPart2({super.key, required this.formData});

  @override
  State<MedicalFormPart2> createState() => _MedicalFormPart2State();
}

class _MedicalFormPart2State extends State<MedicalFormPart2> {
  final _formKey = GlobalKey<FormState>();
  final PatientService _patientService = PatientService();
  final Map<String, dynamic> form2Data = {};

  String? _hearingLeft;
  String? _hearingRight;

  String? _heart;

  String? _eyes;
  String? _respSystem;
  String? _pharynx;

  String? _lungs;
  String? _teeth;
  String? _liver;

  String? _lymphaticGlands;
  String? _spleen;
  String? _skin;

  String? _hernia;
  String? _papillaryReflex;
  String? _spinalReflex;

  String? _urineAlbumin;
  String? _urineSugar;
  String? _urineProtein;

  String? _stoolOccultBlood;
  String? _stoolMicroscope;
  String? _stoolOvaOrCyst;

  String? _bloodGroup;
  String? _genotype;
  String? _vdrlTest;

  String? _otherObservation;
  DateTime? _date;
  String? _remarks;
  String? _medicalOfficerName;
  String? _hospitalAddress;

  // CONTROLLERS
  final TextEditingController _heightMetersController = TextEditingController();
  final TextEditingController _heightCmcontroller = TextEditingController();

  final TextEditingController _weightKgController = TextEditingController();
  final TextEditingController _weightGController = TextEditingController();

  final TextEditingController _withoutGlassesRightController =
      TextEditingController();
  final TextEditingController _withoutGlassesLeftController =
      TextEditingController();
  final TextEditingController _withGlassesRightController =
      TextEditingController();
  final TextEditingController _withGlassesLeftController =
      TextEditingController();
  final TextEditingController _bloodPressureController =
      TextEditingController();

  final TextEditingController _bloodHbController = TextEditingController();

  final TextEditingController _xrayFilmNoController = TextEditingController();
  final TextEditingController _xrayHospitalController = TextEditingController();
  final TextEditingController _xrayReportController = TextEditingController();

  Future<void> _saveForm2() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Prepare data map for Firestore
    final Map<String, dynamic> form2DataMap = {
      'height': {
        'meters': _heightMetersController.text.trim(),
        'centimeters': _heightCmcontroller.text.trim(),
      },
      'weight': {
        'kg': _weightKgController.text.trim(),
        'grams': _weightGController.text.trim(),
      },
      'visualAcuityWithoutGlasses': {
        'rightEye': _withoutGlassesRightController.text.trim(),
        'leftEye': _withoutGlassesLeftController.text.trim(),
      },
      'visualAcuityWithGlasses': {
        'rightEye': _withGlassesRightController.text.trim(),
        'leftEye': _withGlassesLeftController.text.trim(),
      },
      'hearing': {
        'left': _hearingLeft,
        'right': _hearingRight,
      },
      'heart': _heart,
      'bloodPressure': _bloodPressureController.text.trim(),
      'eyes': _eyes,
      'respiratorySystem': _respSystem,
      'pharynx': _pharynx,
      'lungs': _lungs,
      'teeth': _teeth,
      'liver': _liver,
      'lymphaticGlands': _lymphaticGlands,
      'spleen': _spleen,
      'skin': _skin,
      'hernia': _hernia,
      'papillaryReflex': _papillaryReflex,
      'spinalReflex': _spinalReflex,
      'urineTestResults': {
        'albumin': _urineAlbumin,
        'sugar': _urineSugar,
        'protein': _urineProtein,
      },
      'stoolExamination': {
        'occultBlood': _stoolOccultBlood,
        'microscope': _stoolMicroscope,
        'ovaOrCyst': _stoolOvaOrCyst,
      },
      'bloodTests': {
        'hemoglobin': _bloodHbController.text.trim(),
        'bloodGroup': _bloodGroup,
        'genotype': _genotype,
        'vdrlTest': _vdrlTest,
      },
      'chestXray': {
        'filmNumber': _xrayFilmNoController.text.trim(),
        'hospitalName': _xrayHospitalController.text.trim(),
        'report': _xrayReportController.text.trim(),
      },
      'otherObservations': _otherObservation,
      'remarks': _remarks,
      'date': _date?.toIso8601String(), // store as ISO string or Timestamp
      'medicalOfficerName': _medicalOfficerName,
      'hospitalAddress': _hospitalAddress,
    };
    print('Form Data: $form2DataMap');

    final String patientId = widget.formData['matricNumber'] ?? '';

    if (patientId.isEmpty) {
      // Show error: patientId is required
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Patient ID is missing. Cannot save form.')),
      );
      return;
    }

    try {
      final String patientId = widget.formData['matricNumber'];

      await _patientService.saveForm2(
          patientId: patientId, form2Data: form2Data);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Form 2 saved successfully!',
            style: TextStyle(color: Colors.green),
          ),
        ),
      );

      Navigator.pop(context); // Or push to summary screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error saving Form 2: $e',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Material(
            elevation: 10,
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SubAppBar(text: "Create Patient"),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Column(
                                    children: [
                                      const Text("Height",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Form2PatientTextfield(
                                                controller:
                                                    _heightMetersController,
                                                label: "Height in meters"),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Form2PatientTextfield(
                                                controller: _heightCmcontroller,
                                                label: "Height in centimeters"),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                    child: Column(
                                  children: [
                                    const Text("Weight",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Form2PatientTextfield(
                                              controller: _weightKgController,
                                              label: "Weight in kg"),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: Form2PatientTextfield(
                                              controller: _weightGController,
                                              label: "Weight in grams"),
                                        )
                                      ],
                                    )
                                  ],
                                )),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Column(
                                    children: [
                                      const Text(
                                          "Visual Acuity Without Glasses",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Form2PatientTextfield(
                                                controller:
                                                    _withoutGlassesRightController,
                                                label: "Right Eye e.g: (6/6)"),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Form2PatientTextfield(
                                                controller:
                                                    _withoutGlassesLeftController,
                                                label: "Left Eye: (6/6)"),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                    child: Column(
                                  children: [
                                    const Text("Visual Acuity With Glasses",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Form2PatientTextfield(
                                              controller:
                                                  _withGlassesRightController,
                                              label: "Right Eye e.g: (6/6)"),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: Form2PatientTextfield(
                                              controller:
                                                  _withGlassesLeftController,
                                              label: "Left Eye e.g: (6/6)"),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                              ],
                            ),
                            Column(
                              children: [
                                const Text("Hearing",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: HearingDropdown(
                                        label: "Left",
                                        onChanged: (value) {
                                          setState(() {
                                            _hearingLeft = value;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: HearingDropdown(
                                        label: "Right",
                                        onChanged: (value) {
                                          setState(() {
                                            _hearingRight = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text("Heart & Blood Pressure",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: HeartDropdown(
                                          value: _heart,
                                          onChanged: (value) {
                                            setState(() {
                                              _heart = value;
                                            });
                                          }),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: Form2PatientTextfield(
                                        controller: _bloodPressureController,
                                        label: "Blood Pressure",
                                        isRequired: true,
                                        isNumeric: true,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Text("Eyes, Respiratory System, Pharynx",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: EyesDropdown(
                                          value: _eyes,
                                          onChanged: (val) =>
                                              setState(() => _eyes = val)),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: RespiratoryDropdown(
                                          value: _respSystem,
                                          onChanged: (val) => setState(
                                              () => _respSystem = val)),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: PharynxDropdown(
                                          value: _pharynx,
                                          onChanged: (val) =>
                                              setState(() => _pharynx = val)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Text("Lungs, Teeth, Liver",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: LungsDropdown(
                                          value: _lungs,
                                          onChanged: (val) =>
                                              setState(() => _lungs = val)),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: TeethDropdown(
                                          value: _teeth,
                                          onChanged: (val) =>
                                              setState(() => _teeth = val)),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: LiverDropdown(
                                          value: _liver,
                                          onChanged: (val) =>
                                              setState(() => _liver = val)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Text("Lymphatic Glands, Spleen, Skin",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: LymphaticDropdown(
                                          value: _lymphaticGlands,
                                          onChanged: (val) => setState(
                                              () => _lymphaticGlands = val)),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: SpleenDropdown(
                                          value: _spleen,
                                          onChanged: (val) =>
                                              setState(() => _spleen = val)),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: SkinDropdown(
                                          value: _skin,
                                          onChanged: (val) =>
                                              setState(() => _skin = val)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Text("Hernia & Reflexes",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: HerniaDropdown(
                                          value: _hernia,
                                          onChanged: (val) =>
                                              setState(() => _hernia = val)),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: PapillaryReflexDropdown(
                                          value: _papillaryReflex,
                                          onChanged: (val) => setState(
                                              () => _papillaryReflex = val)),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: SpinalReflexDropdown(
                                          value: _spinalReflex,
                                          onChanged: (val) => setState(
                                              () => _spinalReflex = val)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Text("Urine Test Results",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: UrineAlbuminDropdown(
                                        value: _urineAlbumin,
                                        onChanged: (val) =>
                                            setState(() => _urineAlbumin = val),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: UrineSugarDropdown(
                                        value: _urineSugar,
                                        onChanged: (val) =>
                                            setState(() => _urineSugar = val),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: UrineProteinDropdown(
                                        value: _urineProtein,
                                        onChanged: (val) =>
                                            setState(() => _urineProtein = val),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Text("Stool Examination",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: OccultBloodDropdown(
                                        value: _stoolOccultBlood,
                                        onChanged: (val) => setState(
                                            () => _stoolOccultBlood = val),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: MicroscopeDropdown(
                                        value: _stoolMicroscope,
                                        onChanged: (val) => setState(
                                            () => _stoolMicroscope = val),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: OvaOrCystDropdown(
                                        value: _stoolOvaOrCyst,
                                        onChanged: (val) => setState(
                                            () => _stoolOvaOrCyst = val),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Text("Blood Tests",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Form2PatientTextfield(
                                        controller: _bloodHbController,
                                        label: "Hemoglobin (Hb) Level",
                                        isNumeric: true,
                                        isRequired: true,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: BloodGroupDropdown(
                                        value: _bloodGroup,
                                        onChanged: (val) =>
                                            setState(() => _bloodGroup = val),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: GenotypeDropdown(
                                        value: _genotype,
                                        onChanged: (val) =>
                                            setState(() => _genotype = val),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: VdrlTestDropdown(
                                        value: _vdrlTest,
                                        onChanged: (val) =>
                                            setState(() => _vdrlTest = val),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Text("Chest X-Ray",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Form2PatientTextfield(
                                        controller: _xrayFilmNoController,
                                        label: "Film Number",
                                        isRequired: true,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: Form2PatientTextfield(
                                        controller: _xrayHospitalController,
                                        label: "Hospital Name",
                                        isRequired: true,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: Form2PatientTextfield(
                                          controller: _xrayReportController,
                                          label: "Report"),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Text("Other Observations & Final Info",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 7,
                                ),
                                OtherObservationField(
                                  value: _otherObservation,
                                  onChanged: (val) =>
                                      setState(() => _otherObservation = val),
                                ),
                                const SizedBox(height: 10),
                                RemarksField(
                                  value: _remarks,
                                  onChanged: (val) =>
                                      setState(() => _remarks = val),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Flexible(
                                      child: DateField(
                                        selectedDate: _date,
                                        onDateChanged: (val) =>
                                            setState(() => _date = val),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: MedicalOfficerField(
                                        value: _medicalOfficerName,
                                        onChanged: (val) => setState(
                                            () => _medicalOfficerName = val),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                HospitalAddressField(
                                  value: _hospitalAddress,
                                  onChanged: (val) =>
                                      setState(() => _hospitalAddress = val),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            MyButton(
                                text: 'Create',
                                onPressed: _saveForm2,
                                isPrimary: true)
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
