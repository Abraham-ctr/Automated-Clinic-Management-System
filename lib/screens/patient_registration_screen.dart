import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/patient_model.dart';
import '../providers/patient_provider.dart';
import 'package:uuid/uuid.dart';

class PatientRegistrationScreen extends StatefulWidget {
  @override
  _PatientRegistrationScreenState createState() => _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState extends State<PatientRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController regNumberController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController hospitalController = TextEditingController();
  final TextEditingController fitnessDateController = TextEditingController();

  String selectedGender = "Male";
  String selectedBloodGroup = "O+";
  String selectedGenotype = "AA";
  String fitnessReportStatus = "Pending";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register Patient")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: fullNameController,
                decoration: InputDecoration(labelText: "Full Name"),
                validator: (value) => value!.isEmpty ? "Enter full name" : null,
              ),
              TextFormField(
                controller: regNumberController,
                decoration: InputDecoration(labelText: "Registration Number"),
                validator: (value) => value!.isEmpty ? "Enter registration number" : null,
              ),
              TextFormField(
                controller: dobController,
                decoration: InputDecoration(labelText: "Date of Birth"),
                validator: (value) => value!.isEmpty ? "Enter date of birth" : null,
              ),
              DropdownButtonFormField(
                value: fitnessReportStatus,
                decoration: InputDecoration(labelText: "Fitness Report Status"),
                items: ["Cleared", "Pending"].map((status) {
                  return DropdownMenuItem(value: status, child: Text(status));
                }).toList(),
                onChanged: (value) => setState(() => fitnessReportStatus = value!),
              ),
              TextFormField(
                controller: hospitalController,
                decoration: InputDecoration(labelText: "Fitness Report Hospital"),
                validator: (value) => value!.isEmpty ? "Enter hospital name" : null,
              ),
              TextFormField(
                controller: fitnessDateController,
                decoration: InputDecoration(labelText: "Fitness Report Date"),
                validator: (value) => value!.isEmpty ? "Enter fitness test date" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String id = Uuid().v4();
                    Patient newPatient = Patient(
                      id: id,
                      fullName: fullNameController.text,
                      registrationNumber: regNumberController.text,
                      dob: dobController.text,
                      gender: selectedGender,
                      phone: phoneController.text,
                      email: emailController.text,
                      address: addressController.text,
                      bloodGroup: selectedBloodGroup,
                      genotype: selectedGenotype,
                      allergies: [],
                      chronicConditions: [],
                      emergencyContact: {},
                      fitnessReportStatus: fitnessReportStatus,
                      fitnessReportHospital: hospitalController.text,
                      fitnessReportDate: fitnessDateController.text,
                    );

                    Provider.of<PatientProvider>(context, listen: false).addPatient(newPatient);
                    Navigator.pop(context);
                  }
                },
                child: Text("Register Patient"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
