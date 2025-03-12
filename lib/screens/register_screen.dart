// ignore_for_file: library_private_types_in_public_api

import 'package:automated_clinic_management_system/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _regNumberController = TextEditingController();
  // final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String _gender = 'Male';
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    var of = Provider.of<AuthProvider>(context);
    final authProvider = of;
    
    return Scaffold(
      backgroundColor: Colors.grey[200],

      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios)
                        ),

                        const Spacer(),

                        const Text("Admin Register", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0XFFae9719))),

                        const Spacer(),
                      ],
                    ),

                    const SizedBox(height: 20),

                    _buildTextField(_surnameController, "Surname"),
                    _buildTextField(_firstNameController, "First Name"),
                    _buildTextField(_middleNameController, "Middle Name"),
                    _buildTextField(_emailController, "Email", keyboardType: TextInputType.emailAddress),
                    _buildTextField(_phoneController, "Phone", keyboardType: TextInputType.phone),
                    _buildTextField(_regNumberController, "Registration Number"),
                    // _buildTextField(_usernameController, "Username"),
                    _buildPasswordField(_passwordController, "Password", isConfirm: false),
                    _buildPasswordField(_confirmPasswordController, "Confirm Password", isConfirm: true),
                    
                    DropdownButtonFormField(
                      value: _gender,
                      items: ['Male', 'Female'].map((String gender) {
                        return DropdownMenuItem(value: gender, child: Text(gender));
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _gender = newValue as String;
                        });
                      },
                      decoration: const InputDecoration(labelText: "Gender"),
                    ),
                    
                    const SizedBox(height: 20),

                    authProvider.isLoading
                        ? const CircularProgressIndicator()
                        : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              backgroundColor: const Color(0xFF2b1176),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              )
                            ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (_passwordController.text.trim() != _confirmPasswordController.text.trim() ) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Passwords do not match!")),
                                    );
                                    return;
                                  }
                                  authProvider.register(
                                    surname: _surnameController.text.trim(),
                                    firstName: _firstNameController.text.trim(),
                                    middleName: _middleNameController.text.trim(),
                                    email: _emailController.text.trim(),
                                    phone: _phoneController.text.trim(),
                                    regNumber: _regNumberController.text.trim(),
                                    // username: _usernameController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    gender: _gender,
                                    context: context,
                                  );
                                }
                              },
                              child: const Text("Register"),
                            ),
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

  Widget _buildTextField(TextEditingController controller, String label, {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        validator: (value) => value!.isEmpty ? "This field is required" : null,
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String label, {required bool isConfirm}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        obscureText: isConfirm ? _obscureConfirmPassword : _obscurePassword,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(
              isConfirm ? (_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility) 
                        : (_obscurePassword ? Icons.visibility_off : Icons.visibility),
            ),
            onPressed: () {
              setState(() {
                if (isConfirm) {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                } else {
                  _obscurePassword = !_obscurePassword;
                }
              });
            },
          ),
        ),
        validator: (value) => value!.length < 6 ? "Password must be at least 6 characters" : null,
      ),
    );
  }
}
