import 'package:automated_clinic_management_system/widgets/form_header.dart';
import 'package:flutter/material.dart';

class MedicalFormPart2 extends StatefulWidget {

  final Map<String, String> formData;
  const MedicalFormPart2({super.key, required this.formData});

  @override
  State<MedicalFormPart2> createState() => _MedicalFormPart2State();
}

class _MedicalFormPart2State extends State<MedicalFormPart2> {
  final _formKey = GlobalKey<FormState>();
  
  
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
                child: const Column(
                  children: [

                    FormHeader(text: "Medical Form"),

                    Text(
                      "Part 2",
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),

                    SizedBox(height: 10),
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
