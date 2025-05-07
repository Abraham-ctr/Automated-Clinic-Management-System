import 'package:automated_clinic_management_system/core/utils/utilities.dart';
import 'package:automated_clinic_management_system/providers/auth_provider.dart';
import 'package:automated_clinic_management_system/widgets/form_header.dart';
import 'package:automated_clinic_management_system/widgets/my_button.dart';
import 'package:automated_clinic_management_system/widgets/my_dropdown_field.dart';
import 'package:automated_clinic_management_system/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterAdminScreen extends StatefulWidget {
  const RegisterAdminScreen({super.key});

  @override
  RegisterAdminScreenState createState() => RegisterAdminScreenState();
}

class RegisterAdminScreenState extends State<RegisterAdminScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  // controllers
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _regNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String _gender = 'Male';
  String _role = 'Nurse';

  @override
  void dispose() {
    for (final c in [
      _surnameController,
      _firstNameController,
      _middleNameController,
      _emailController,
      _phoneController,
      _regNumberController,
      _passwordController,
      _confirmPasswordController,
      _scrollController,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _onRegisterPressed() async {
    if (!_formKey.currentState!.validate()) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      return;
    }
    setState(() => isLoading = true);

    try {
      // 1) attempt registration
      await context.read<AuthProvider>().register(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            surname: capitalizeAndTrim(_surnameController.text),
            firstName: capitalizeAndTrim(_firstNameController.text),
            middleName: capitalizeAndTrim(_middleNameController.text),
            phoneNumber: _phoneController.text.trim(),
            regNumber: _regNumberController.text.toUpperCase().trim(),
            gender: _gender,
            role: _role,
          );

      // 2) get the provider to inspect error/success
      final auth = context.read<AuthProvider>();
      if (auth.errorMessage != null) {
        // Show the error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(auth.errorMessage!)),
        );
      } else {
        // Navigate away on success
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e, st) {
      // Unexpected failure (shouldn’t normally happen)
      debugPrint('🔥 Registration exception: $e\n$st');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpected error: ${e.toString()}')),
      );
    } finally {
      // ALWAYS turn off the loader
      if (mounted) {
        setState(() => isLoading = false);
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
            child: Row(
              children: [
                // LEFT COLUMN: FORM
                Expanded(
                  flex: 1,
                  child: Material(
                    elevation: 10,
                    child: Scrollbar(
                      controller: _scrollController,
                      thickness: 5,
                      interactive: true,
                      trackVisibility: true,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Form(
                          key: _formKey,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                // borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey)),
                            child: Column(
                              children: [
                                const FormHeader(text: "REGISTER"),
                                const SizedBox(height: 7),
                                Row(
                                  children: [
                                    Expanded(
                                        child: MyTextField(
                                            controller: _surnameController,
                                            label: "Surname",
                                            isRequired: true,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return "Surname is required";
                                              }
                                              if (!RegExp(r"^[a-zA-Z]+$")
                                                  .hasMatch(value.trim())) {
                                                return "Invalid surname (letters only)";
                                              }
                                              return null;
                                            })),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: MyTextField(
                                          controller: _firstNameController,
                                          label: "First Name",
                                          isRequired: true,
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "First Name is required";
                                            }
                                            if (!RegExp(r"^[a-zA-Z]+$")
                                                .hasMatch(value.trim())) {
                                              return "Invalid first name (letters only)";
                                            }
                                            return null;
                                          }),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                        child: MyTextField(
                                            controller: _middleNameController,
                                            label: "Middle Name",
                                            isRequired: true,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return "Middle Name is required";
                                              }
                                              if (!RegExp(r"^[a-zA-Z]+$")
                                                  .hasMatch(value.trim())) {
                                                return "Invalid middle name (letters only)";
                                              }
                                              return null;
                                            })),
                                  ],
                                ),
                                MyTextField(
                                    controller: _emailController,
                                    label: "Email",
                                    isRequired: true,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return "Email is required";
                                      }
                                      if (!RegExp(
                                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                          .hasMatch(value.trim())) {
                                        return "Enter a valid email address";
                                      }
                                      return null;
                                    }),
                                MyTextField(
                                    controller: _phoneController,
                                    label: "Phone Number",
                                    isRequired: true,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return "Phone Number is required";
                                      }
                                      if (!RegExp(r"^[0-9]{10,15}$")
                                          .hasMatch(value.trim())) {
                                        return "Enter a valid phone number (10-15 digits)";
                                      }
                                      return null;
                                    }),
                                MyTextField(
                                    controller: _regNumberController,
                                    label: "Registration Number / Staff ID",
                                    isRequired: true,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return "Registration Number is required";
                                      }
                                      if (!RegExp(r"^[a-zA-Z0-9]+$")
                                          .hasMatch(value.trim())) {
                                        return "Enter a valid Registration Number (letters & numbers only)";
                                      }
                                      return null;
                                    }),
                                Row(
                                  children: [
                                    Expanded(
                                      child: MyDropdownField(
                                        label: "Gender",
                                        value: _gender,
                                        items: const ["Male", "Female"],
                                        onChanged: (value) =>
                                            setState(() => _gender = value!),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: MyDropdownField(
                                        label: "Role",
                                        value: _role,
                                        items: const ["Nurse", "Doctor"],
                                        onChanged: (value) =>
                                            setState(() => _role = value!),
                                      ),
                                    ),
                                  ],
                                ),
                                MyTextField(
                                    controller: _passwordController,
                                    label: "Password",
                                    isPassword: true,
                                    isRequired: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Password is required";
                                      } else if (value.length < 8) {
                                        return "Password must be at least 8 characters";
                                      } else if (!RegExp(r'[A-Z]')
                                          .hasMatch(value)) {
                                        return "Password must contain at least one uppercase letter";
                                      } else if (!RegExp(r'[a-z]')
                                          .hasMatch(value)) {
                                        return "Password must contain at least one lowercase letter";
                                      } else if (!RegExp(r'\d')
                                          .hasMatch(value)) {
                                        return "Password must contain at least one number";
                                      } else if (!RegExp(
                                              r'[!@#$%^&*(),.?":{}|<>]')
                                          .hasMatch(value)) {
                                        return "Password must contain at least one special character";
                                      }
                                      return null;
                                    }),
                                MyTextField(
                                    controller: _confirmPasswordController,
                                    label: "Confirm Password",
                                    isPassword: true,
                                    isRequired: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Password is required';
                                      } else if (value !=
                                          _passwordController.text) {
                                        return 'Passwords do not match';
                                      }
                                      return null;
                                    }),
                                const Text(
                                  'Password must be at least 8 characters and include uppercase, lowercase, number, and special character.',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                const SizedBox(height: 15),
                                MyButton(
                                  text: "Register",
                                  isLoading: isLoading,
                                  onPressed:
                                      isLoading ? null : _onRegisterPressed,
                                  isPrimary: true,
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // RIGHT COLUMN: IMAGE
                Expanded(
                  flex: 1,
                  child: Container(
                    // color: Colors.green,
                    padding: const EdgeInsets.all(20),
                    child: Image.asset(
                      'assets/images/auth/signUp.png',
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
