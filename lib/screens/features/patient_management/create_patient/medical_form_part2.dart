import 'package:automated_clinic_management_system/widgets/auth/my_button.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/blood_test_fields.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/chest_xray_fields.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/eyes_resp_pharynx_fields.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/final_form_section.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/hearing_fields.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/heart_and_BP_fields.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/height_weight_fields.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/hernia_reflex_fields.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/lungs_teeth_liver_fields.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/lymph_spleen_skin_fields.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/stool_fields.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/urine_fields.dart';
import 'package:automated_clinic_management_system/widgets/patient/form2/visual_acuity_fields.dart';
import 'package:automated_clinic_management_system/widgets/sub_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MedicalFormPart2 extends StatefulWidget {
  final Map<String, dynamic> formData;
  const MedicalFormPart2({super.key, required this.formData});

  @override
  State<MedicalFormPart2> createState() => _MedicalFormPart2State();
}

class _MedicalFormPart2State extends State<MedicalFormPart2> {
  final _formKey = GlobalKey<FormState>();

  String? _hearingLeft;
  String? _hearingRight;
  String? _heart;
  String _bloodPressure = '';
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
  String? _bloodHb;
  String? _bloodGroup;
  String? _genotype;
  String? _vdrlTest;
  String? _xrayFilmNo;
  String? _xrayHospital;
  String? _xrayReport;
  DateTime? _date;
  String? _otherObs;
  String? _remarks;
  String? _officerName;
  String? _hospitalAddr;

  Future<void> _saveForm2() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    // Collect data into a map
    final form2Data = {
      'heightMeters': int.tryParse(_heightMetersController.text) ?? 0,
      'heightCm': int.tryParse(_heightCmcontroller.text) ?? 0,
      'weightKg': int.tryParse(_weightKgController.text) ?? 0,
      'weightG': int.tryParse(_weightGController.text) ?? 0,
      'visualAcuityWithoutGlassesRight': _withoutGlassesRightController.text,
      'visualAcuityWithoutGlassesLeft': _withoutGlassesLeftController.text,
      'visualAcuityWithGlassesRight': _withGlassesRightController.text,
      'visualAcuityWithGlassesLeft': _withGlassesLeftController.text,
      'hearingLeft': _hearingLeft ?? '',
      'hearingRight': _hearingRight ?? '',
      'heart': _heart ?? '',
      'bloodPressure': _bloodPressure,
      'eyes': _eyes ?? '',
      'respiratorySystem': _respSystem ?? '',
      'pharynx': _pharynx ?? '',
      'lungs': _lungs ?? '',
      'teeth': _teeth ?? '',
      'liver': _liver ?? '',
      'lymphaticGlands': _lymphaticGlands ?? '',
      'spleen': _spleen ?? '',
      'skin': _skin ?? '',
      'hernia': _hernia ?? '',
      'papillaryReflex': _papillaryReflex ?? '',
      'spinalReflex': _spinalReflex ?? '',
      'urineAlbumin': _urineAlbumin ?? '',
      'urineSugar': _urineSugar ?? '',
      'urineProtein': _urineProtein ?? '',
      'stoolOccultBlood': _stoolOccultBlood ?? '',
      'stoolMicroscope': _stoolMicroscope ?? '',
      'stoolOvaOrCyst': _stoolOvaOrCyst ?? '',
      'bloodHb': _bloodHb ?? '',
      'bloodGroup': _bloodGroup ?? '',
      'genotype': _genotype ?? '',
      'vdrlTest': _vdrlTest ?? '',
      'chestXRayFilmNo': _xrayFilmNo ?? '',
      'chestXRayHospital': _xrayHospital ?? '',
      'chestXRayReport': _xrayReport ?? '',
      'otherObservation': _otherObs ?? '',
      'remarks': _remarks ?? '',
      'date': _date?.toIso8601String(),
      'medicalOfficerName': _officerName ?? '',
      'hospitalAddress': _hospitalAddr ?? '',
    };
    print('Form Data: $form2Data');

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
      final docRef =
          FirebaseFirestore.instance.collection('patients').doc(patientId);

      await docRef.set({
        'form2': form2Data,
      }, SetOptions(merge: true)); // merge: true to not overwrite other data

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form 2 saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving form: $e')),
      );
    }
  }

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
                            HeightWeightFields(
                                heightMetersController: _heightMetersController,
                                heightCmController: _heightCmcontroller,
                                weightKgController: _weightKgController,
                                weightGController: _weightGController),
                            VisualAcuityFields(
                                withoutGlassesRightController:
                                    _withoutGlassesRightController,
                                withoutGlassesLeftController:
                                    _withoutGlassesLeftController,
                                withGlassesRightController:
                                    _withGlassesRightController,
                                withGlassesLeftController:
                                    _withGlassesLeftController),
                            HearingFields(
                              hearingLeft: _hearingLeft,
                              hearingRight: _hearingRight,
                              onLeftChanged: (val) =>
                                  setState(() => _hearingLeft = val),
                              onRightChanged: (val) =>
                                  setState(() => _hearingRight = val),
                            ),
                            HeartAndBPFields(
                              heart: _heart,
                              bloodPressure: _bloodPressure,
                              onHeartChanged: (val) =>
                                  setState(() => _heart = val),
                              onBloodPressureChanged: (val) =>
                                  setState(() => _bloodPressure = val),
                            ),
                            EyesRespPharynxFields(
                              eyes: _eyes,
                              respiratorySystem: _respSystem,
                              pharynx: _pharynx,
                              onEyesChanged: (val) =>
                                  setState(() => _eyes = val),
                              onRespChanged: (val) =>
                                  setState(() => _respSystem = val),
                              onPharynxChanged: (val) =>
                                  setState(() => _pharynx = val),
                            ),
                            LungsTeethLiverFields(
                              lungs: _lungs,
                              teeth: _teeth,
                              liver: _liver,
                              onLungsChanged: (val) =>
                                  setState(() => _lungs = val),
                              onTeethChanged: (val) =>
                                  setState(() => _teeth = val),
                              onLiverChanged: (val) =>
                                  setState(() => _liver = val),
                            ),
                            LymphSpleenSkinFields(
                              lymphaticGlands: _lymphaticGlands,
                              spleen: _spleen,
                              skin: _skin,
                              onLymphChanged: (val) =>
                                  setState(() => _lymphaticGlands = val),
                              onSpleenChanged: (val) =>
                                  setState(() => _spleen = val),
                              onSkinChanged: (val) =>
                                  setState(() => _skin = val),
                            ),
                            HerniaReflexFields(
                              hernia: _hernia,
                              papillaryReflex: _papillaryReflex,
                              spinalReflex: _spinalReflex,
                              onHerniaChanged: (val) =>
                                  setState(() => _hernia = val),
                              onPapillaryChanged: (val) =>
                                  setState(() => _papillaryReflex = val),
                              onSpinalChanged: (val) =>
                                  setState(() => _spinalReflex = val),
                            ),
                            UrineFields(
                              albumin: _urineAlbumin,
                              sugar: _urineSugar,
                              protein: _urineProtein,
                              onAlbuminChanged: (val) =>
                                  setState(() => _urineAlbumin = val),
                              onSugarChanged: (val) =>
                                  setState(() => _urineSugar = val),
                              onProteinChanged: (val) =>
                                  setState(() => _urineProtein = val),
                            ),
                            StoolFields(
                              occultBlood: _stoolOccultBlood,
                              microscope: _stoolMicroscope,
                              ovaOrCyst: _stoolOvaOrCyst,
                              onOccultBloodChanged: (val) =>
                                  setState(() => _stoolOccultBlood = val),
                              onMicroscopeChanged: (val) =>
                                  setState(() => _stoolMicroscope = val),
                              onOvaOrCystChanged: (val) =>
                                  setState(() => _stoolOvaOrCyst = val),
                            ),
                            BloodTestFields(
                              bloodHb: _bloodHb,
                              bloodGroup: _bloodGroup,
                              genotype: _genotype,
                              vdrlTest: _vdrlTest,
                              onBloodHbChanged: (val) =>
                                  setState(() => _bloodHb = val),
                              onBloodGroupChanged: (val) =>
                                  setState(() => _bloodGroup = val),
                              onGenotypeChanged: (val) =>
                                  setState(() => _genotype = val),
                              onVdrlTestChanged: (val) =>
                                  setState(() => _vdrlTest = val),
                            ),
                            ChestXRayFields(
                              filmNo: _xrayFilmNo,
                              hospital: _xrayHospital,
                              report: _xrayReport,
                              onFilmNoChanged: (val) =>
                                  setState(() => _xrayFilmNo = val),
                              onHospitalChanged: (val) =>
                                  setState(() => _xrayHospital = val),
                              onReportChanged: (val) =>
                                  setState(() => _xrayReport = val),
                            ),
                            FinalFormSection(
                              otherObservation: _otherObs,
                              remarks: _remarks,
                              date: _date,
                              medicalOfficerName: _officerName,
                              hospitalAddress: _hospitalAddr,
                              onOtherObservationChanged: (val) =>
                                  setState(() => _otherObs = val),
                              onRemarksChanged: (val) =>
                                  setState(() => _remarks = val),
                              onDateChanged: (val) =>
                                  setState(() => _date = val),
                              onMedicalOfficerNameChanged: (val) =>
                                  setState(() => _officerName = val),
                              onHospitalAddressChanged: (val) =>
                                  setState(() => _hospitalAddr = val),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MyButton(
                                text: 'Save',
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
