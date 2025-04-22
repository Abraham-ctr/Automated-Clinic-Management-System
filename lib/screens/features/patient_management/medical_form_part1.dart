import 'package:automated_clinic_management_system/widgets/form_header.dart';
import 'package:automated_clinic_management_system/widgets/my_button.dart';
import 'package:automated_clinic_management_system/widgets/patient_management/patient_textfield.dart';
import 'package:flutter/material.dart';

class MedicalFormPart1 extends StatefulWidget {
 const MedicalFormPart1({super.key});

  @override
  State<MedicalFormPart1> createState() => _MedicalFormPart1State();
}

class _MedicalFormPart1State extends State<MedicalFormPart1> {
  final _formKey = GlobalKey<FormState>();
  // Controllers for text fields
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();

  final TextEditingController dobController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController maritalStatusController = TextEditingController();

  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController placeOfBirthController = TextEditingController();

  // Dropdown values
  String? selectedDepartment;
  String? selectedCourse; 

  // Options for dropdowns
  final List<String> departments = [
    "Computer Science",
    "Management Sciences",
    "Criminology & Security Studies",
    "Mass Communication",
    "Biological Sciences",
    "Chemical Sciences",
    "Economics",
  ];

  final Map<String, List<String>> coursesByDepartment = {
    "Computer Science": ["Computer Science", "Software Engineering", "Cybersecurity"],
    "Management Sciences": ["Accounting", "Business Administration"],
    "Criminology & Security Studies": ["Criminology & Security Studies"],
    "Mass Communication": ["Mass Communication"],
    "Biological Sciences": ["Microbiology"],
    "Chemical Sciences": ["Biochemistry", "Industrial Chemistry"],
    "Economics": ["Economics"],
  };

  final TextEditingController parentNameController = TextEditingController();
  final TextEditingController parentPhoneController = TextEditingController();
  final TextEditingController nextOfKinNameController = TextEditingController();
  final TextEditingController nextOfKinAddressController = TextEditingController();
  final TextEditingController nextOfKinPhoneController = TextEditingController();

  final TextEditingController healthStatusController = TextEditingController();
  final TextEditingController admissionHistoryController = TextEditingController();
  final TextEditingController otherMedicalHistoryController = TextEditingController();
  final TextEditingController familyHealthController = TextEditingController();
  
  // Immunization Controllers
  final TextEditingController yellowFeverDateController = TextEditingController();
  final TextEditingController smallPoxDateController = TextEditingController();
  final TextEditingController tetanusDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  children: [

                    const FormHeader(text: "Medical Form"),

                    const Text(
                      "Part 1",
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),

                    const SizedBox(height: 10),
                    // **Personal Details**
                    Row(
                      children: [
                        Expanded(
                          child: PatientTextfield(
                            controller: surnameController,
                            label: "Surname",
                            isRequired: true
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: PatientTextfield(
                            controller: firstNameController,
                            label: "First Name",
                            isRequired: true
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: PatientTextfield(
                            controller: middleNameController,
                            label: "Middle Name",
                            isRequired: true
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 10),
                     Row(
                      children: [
                        Expanded(
                          child: _buildDatePickerField(
                            context, dobController, "Date of Birth"
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: _buildDropdownField(sexController, "Sex", ["Male", "Female"]),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: _buildDropdownField(maritalStatusController, "Marital Status", ["Single", "Married", "Divorced"]),
                        )
                      ],
                    ),

                    const SizedBox(height: 10),
                  // **Nationality**
                  Row(
                    children: [
                      Expanded(child: PatientTextfield(controller: nationalityController, label: "Nationality", isRequired: true)),
                      const SizedBox(width: 10,),
                      Expanded(child: PatientTextfield(controller: placeOfBirthController, label: "Place of Birth", isRequired: true)),
                    ],
                  ),

                    const SizedBox(height: 10),
                    // **Department & Course Option Dropdown**
                    Row(
                      children: [
                        Expanded(
                          child:  _buildDepartmentDropdown(),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: _buildCourseDropdown(),
                        )
                      ],
                    ),

                    const SizedBox(height: 10),
                    // **Parent & Next of Kin Details**
                    PatientTextfield(controller: parentNameController, label: "Parent's Name", isRequired: true),
                    const SizedBox(height: 10),
                    PatientTextfield(controller: parentPhoneController, label: "Parent's Phone", isRequired: true, isNumeric: true),
                    const SizedBox(height: 10),
                    PatientTextfield(controller: nextOfKinNameController, label: "Next of Kin", isRequired: true),
                    const SizedBox(height: 10),
                    PatientTextfield(controller: nextOfKinAddressController, label: "Next of Kin Address", isRequired: true),
                    const SizedBox(height: 10),
                    PatientTextfield(controller: nextOfKinPhoneController, label: "Next of Kin Phone", isRequired: true, isNumeric: true),

                    const SizedBox(height: 10),
                    // **Medical History Questions**
                    _buildDropdownField(healthStatusController, "How is your health?", ["Good", "Fair", "Poor"]),
                    const SizedBox(height: 10),
                    PatientTextfield(controller: admissionHistoryController, label: "Past Hospital Admissions", isRequired: false),
                    const SizedBox(height: 10),
                    PatientTextfield(controller: otherMedicalHistoryController, label: "Other Medical History", isRequired: false),
                    const SizedBox(height: 10),
                    PatientTextfield(controller: familyHealthController, label: "Is your family healthy?", isRequired: true),

                    const SizedBox(height: 10),
                    // **Immunization Records**
                    _buildYesNoField("Immunized for Yellow Fever?", yellowFeverDateController),
                    const SizedBox(height: 10),
                    _buildYesNoField("Immunized for Small Pox?", smallPoxDateController),
                    const SizedBox(height: 10),
                    _buildYesNoField("Immunized for Tetanus?", tetanusDateController),

                    const SizedBox(height: 15),
                    // **Submit Button**
                    MyButton(
                      text: "Next Page",
                      isPrimary: false,
                      onPressed: () {
                        // Validate the form
                        if (_formKey.currentState?.validate() ?? false) {
                          // Create a map to pass the form data
                          Map<String, String> formData = {
                            'surname': surnameController.text,
                            'firstName': firstNameController.text,
                            'middleName': middleNameController.text,
                            'dob': dobController.text,
                            'sex': sexController.text,
                            'maritalStatus': maritalStatusController.text,
                            'nationality': nationalityController.text,
                            'placeOfBirth': placeOfBirthController.text,
                            'department': selectedDepartment ?? '',
                            'course': selectedCourse ?? '',
                            'parentName': parentNameController.text,
                            'parentPhone': parentPhoneController.text,
                            'nextOfKinName': nextOfKinNameController.text,
                            'nextOfKinAddress': nextOfKinAddressController.text,
                            'nextOfKinPhone': nextOfKinPhoneController.text,
                            'healthStatus': healthStatusController.text,
                            'admissionHistory': admissionHistoryController.text,
                            'otherMedicalHistory': otherMedicalHistoryController.text,
                            'familyHealth': familyHealthController.text,
                            'yellowFeverDate': yellowFeverDateController.text,
                            'smallPoxDate': smallPoxDateController.text,
                            'tetanusDate': tetanusDateController.text,
                          };

                          // Navigate to Part 2 and pass the form data
                          Navigator.pushNamed(context, '/registerPatient2', arguments: formData);
                        }
                      },
                    ),
                    const SizedBox(height: 15),

                  ],
                ),
              )
            ),
          ),
        ),
      ),
    );
  }

  // **Helper Method: Date Picker**
  Widget _buildDatePickerField(BuildContext context, TextEditingController controller, String label) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
    
        if (pickedDate != null) {
          // Format to DD-MM-YYYY
          String formattedDate = "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
          controller.text = formattedDate;
        }
      },
      child: AbsorbPointer( // Prevents keyboard from appearing
        child: PatientTextfield(
          controller: controller,
          label: label,
          isRequired: true,
          isDate: true,
        ),
      ),
    );
  }

  // **Helper Method: Dropdown for Sex, Marital Status, Health Status**
  Widget _buildDropdownField(TextEditingController controller, String label, List<String> options) {
    final currentValue = options.contains(controller.text) ? controller.text : null;

    return DropdownButtonFormField<String>(
      value: currentValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      items: options.map((String option) {
        return DropdownMenuItem(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          controller.text = value!;
        });
      },
      validator: (value) => value == null ? "$label is required" : null,
    );
  }

  Widget _buildDepartmentDropdown() {
    return DropdownButtonFormField<String>(
      value: departments.contains(selectedDepartment) ? selectedDepartment : null,
      decoration: InputDecoration(
        labelText: "Department",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      items: departments.map((dept) {
        return DropdownMenuItem(
          value: dept,
          child: Text(dept),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedDepartment = value;
          selectedCourse = null; // Reset course when department changes
        });
      },
      validator: (value) => value == null ? "Department is required" : null,
    );
  }

  Widget _buildCourseDropdown() {
    List<String> courseOptions = selectedDepartment != null && coursesByDepartment.containsKey(selectedDepartment)
        ? coursesByDepartment[selectedDepartment]!
        : [];

    return DropdownButtonFormField<String>(
      value: courseOptions.contains(selectedCourse) ? selectedCourse : null,
      decoration: InputDecoration(
        labelText: "Course",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      items: courseOptions.map((course) {
        return DropdownMenuItem(
          value: course,
          child: Text(course),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedCourse = value;
        });
      },
      validator: (value) => value == null ? "Course is required" : null,
    );
  }

  // **Helper Method: Yes/No Immunization**
  Widget _buildYesNoField(String label, TextEditingController dateController) {
    return _buildDropdownField(dateController, label, ["Yes", "No"]);
  }


}