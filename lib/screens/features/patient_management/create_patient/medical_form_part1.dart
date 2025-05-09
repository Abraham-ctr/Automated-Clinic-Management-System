import 'package:automated_clinic_management_system/widgets/patient/department_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/marital_status_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/nationality_dropdown.dart';
import 'package:automated_clinic_management_system/widgets/patient/patient_datefield.dart';
import 'package:automated_clinic_management_system/widgets/patient/patient_textfield.dart';
import 'package:automated_clinic_management_system/widgets/patient/sex_dropdown.dart';
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

  String? selectedNationality;
  String? selectedDepartment;
  String? selectedCourse;

  final Map<String, List<String>> departmentCourses = {
    'Computer Science': ['BSc Computer Science', 'BSc Cybersecurity'],
    'Mass Communication': ['BSc Mass Communication'],
    'Business Administration': ['BSc Business Admin', 'BSc Marketing'],
    'Biochemistry': ['BSc Biochemistry'],
    'Microbiology': ['BSc Microbiology'],
    'Economics': ['BSc Economics'],
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

  final TextEditingController _place0fBirthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Material(
            elevation: 10,
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
                              isDate: false,
                            ),
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: PatientTextfield(
                                  controller: _surnameController,
                                  label: "Surname",
                                  isDate: false,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: PatientTextfield(
                                    controller: _firstNameController,
                                    label: "First Name"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: PatientTextfield(
                                    controller: _otherNamesController,
                                    label: "Other Names"),
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
                                  onChanged: (val) =>
                                      setState(() => selectedNationality = val),
                                ),
                              ),

                              const SizedBox(
                                width: 10,
                              ),

                              // PLACE OF BIRTH
                              Flexible(
                                child: PatientTextfield(
                                  controller: _place0fBirthController,
                                  label: 'Place of Birth',
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
                                  departments: departmentCourses.keys.toList(),
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
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
