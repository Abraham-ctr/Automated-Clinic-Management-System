import 'package:automated_clinic_management_system/core/services/patient_service.dart';
import 'package:automated_clinic_management_system/core/utils/utilities.dart';
import 'package:automated_clinic_management_system/screens/features/patient_management/create_patient/medical_form_part2.dart';
import 'package:automated_clinic_management_system/widgets/auth/my_button.dart';
import 'package:automated_clinic_management_system/widgets/patient/form1/department_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form1/marital_status_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form1/nationality_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/form1/patient_datefield.dart';
import 'package:automated_clinic_management_system/widgets/patient/form1/patient_textfield.dart';
import 'package:automated_clinic_management_system/widgets/patient/form1/sex_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/sub_app_bar.dart';
import 'package:flutter/material.dart';

class MedicalFormPart1 extends StatefulWidget {
  const MedicalFormPart1({super.key});

  @override
  State<MedicalFormPart1> createState() => _MedicalFormPart1State();
}

class _MedicalFormPart1State extends State<MedicalFormPart1> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {};
  final PatientService _patientService = PatientService();

  String? selectedNationality;
  String? selectedDepartment;
  String? selectedCourse;

  final Map<String, List<String>> departmentCourses = {
    'Computer Sciences': [
      'Computer Science',
      'Cybersecurity',
      'Software Engineering'
    ],
    'Chemical Sciences': ['Biochemistry', 'Industrial Chemistry'],
    'Biological Sciences': ['Microbiology'],
    'Management Sciences': [
      'Accounting',
      'Business Administration',
      'Industrial Relations & Personnel Management'
    ],
    'Mass Communication': ['Mass Communication'],
    'Economics': ['Economics'],
    'Allied Health Sciences': [
      'Nursing',
      'Medical Laboratory Science',
      'Public Health'
    ],
  };

  List<String> get availableCourses {
    return departmentCourses[selectedDepartment] ?? [];
  }

  // CONTROLLERS
  final TextEditingController _matricNumberController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _otherNamesController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  final TextEditingController _placeOfBirthController = TextEditingController();
  final TextEditingController _nameOfParentController = TextEditingController();
  final TextEditingController _parentPhoneNumbercontroller =
      TextEditingController();
  final TextEditingController _nameOfNextOfKin = TextEditingController();
  final TextEditingController _phoneOfNextOfKin = TextEditingController();

  @override
  void dispose() {
    _matricNumberController.dispose();
    _surnameController.dispose();
    _firstNameController.dispose();
    _otherNamesController.dispose();
    _dobController.dispose();
    _placeOfBirthController.dispose();
    _nameOfParentController.dispose();
    _parentPhoneNumbercontroller.dispose();
    _nameOfNextOfKin.dispose();
    _phoneOfNextOfKin.dispose();
    super.dispose();
  }

  Future<void> _saveForm1() async {
    if (!_formKey.currentState!.validate()) {
      // If the form is not valid, return early
      return;
    }
    _formKey.currentState!.save(); // This calls onSaved handlers if any

    // Collect all the data from controllers and dropdowns
    formData['matricNumber'] =
        _matricNumberController.text.trim().toUpperCase();
    formData['surname'] = capitalizeAndTrim(_surnameController.text);
    formData['firstName'] = capitalizeAndTrim(_firstNameController.text);
    formData['otherNames'] = capitalizeAndTrim(_otherNamesController.text);
    formData['dateOfBirth'] = _dobController.text.trim();

    formData['sex'] = formData['sex'] ?? '';
    formData['marital_status'] = formData['marital_status'] ?? '';
    formData['nationality'] = selectedNationality ?? '';

    formData['placeOfBirth'] = capitalizeAndTrim(_placeOfBirthController.text);
    formData['department'] = selectedDepartment ?? '';
    formData['course'] = selectedCourse ?? '';

    formData['nameOfParent'] = capitalizeAndTrim(_nameOfParentController.text);
    formData['parentPhoneNumber'] = _parentPhoneNumbercontroller.text.trim();
    formData['nameOfNextOfKin'] = capitalizeAndTrim(_nameOfNextOfKin.text);
    formData['phoneOfNextOfKin'] = _phoneOfNextOfKin.text.trim();

    print('Form Data: $formData');

    try {
      final String patientId =
          formData['matricNumber']; // use matric number as the ID
      if (patientId.isEmpty) {
        throw Exception('Matric Number is required to save the form');
      }

      await _patientService.saveForm1(
        patientId: patientId,
        form1Data: formData,
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Form 1 saved successfully!',
                style: TextStyle(color: Colors.green))),
      );

      // Navigate to Part 2
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MedicalFormPart2(formData: formData),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          'Error saving Form 1: $e',
          style: const TextStyle(color: Colors.red),
        )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(30),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 300,
                              child: PatientTextfield(
                                controller: _matricNumberController,
                                label: "Matric Number",
                                isRequired: true,
                              ),
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: PatientTextfield(
                                    controller: _surnameController,
                                    label: "Surname",
                                    isRequired: true,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: PatientTextfield(
                                    controller: _firstNameController,
                                    label: "First Name",
                                    isRequired: true,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: PatientTextfield(
                                    controller: _otherNamesController,
                                    label: "Other Names",
                                    isRequired: true,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: PatientDateField(
                                    controller: _dobController,
                                    label: "Date of Birth",
                                    isRequired: true,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: SexDropdown(
                                    onChanged: (value) {
                                      setState(() {
                                        formData['sex'] = value;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: MaritalStatusDropdown(
                                    onChanged: (value) {
                                      setState(() {
                                        formData['marital_status'] = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                // NATIONALITY
                                Flexible(
                                  child: NationalityDropdown(
                                    value: selectedNationality,
                                    onChanged: (val) => setState(
                                        () => selectedNationality = val),
                                  ),
                                ),

                                const SizedBox(
                                  width: 10,
                                ),

                                // PLACE OF BIRTH
                                Flexible(
                                  child: PatientTextfield(
                                    controller: _placeOfBirthController,
                                    label: 'Place of Birth',
                                    isRequired: true,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                // DEPARTMENT
                                Flexible(
                                  child: DepartmentDropdown(
                                    selectedDepartment: selectedDepartment,
                                    onChanged: (val) {
                                      setState(() {
                                        selectedDepartment = val;
                                        selectedCourse =
                                            null; // Reset course when department changes
                                      });
                                    },
                                    departments:
                                        departmentCourses.keys.toList(),
                                  ),
                                ),

                                const SizedBox(
                                  width: 10,
                                ),

                                // COURSE
                                Flexible(
                                  child: CourseDropdown(
                                    selectedCourse: selectedCourse,
                                    onChanged: (val) {
                                      setState(() {
                                        selectedCourse = val;
                                      });
                                    },
                                    courses: availableCourses,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                // NAME OF PARENT
                                Flexible(
                                  child: PatientTextfield(
                                    controller: _nameOfParentController,
                                    label: "Name of Parent/Guardian",
                                    isRequired: true,
                                  ),
                                ),

                                const SizedBox(
                                  width: 10,
                                ),

                                // PHONE NUMBER OF PARENT
                                Flexible(
                                  child: PatientTextfield(
                                    controller: _parentPhoneNumbercontroller,
                                    label: "Parent/Guardian Phone Number",
                                    isNumeric: true,
                                    isRequired: true,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: PatientTextfield(
                                    controller: _nameOfNextOfKin,
                                    label: "Name of next of kin",
                                    isRequired: true,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: PatientTextfield(
                                    controller: _phoneOfNextOfKin,
                                    label: "Phone number of next of kin",
                                    isRequired: true,
                                  ),
                                )
                              ],
                            ),
                            MyButton(
                                text: 'Submit & Proceed',
                                onPressed: _saveForm1,
                                isPrimary: true),
                            const SizedBox(
                              height: 20,
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
