import 'package:automated_clinic_management_system/services/auth_service.dart';
import 'package:automated_clinic_management_system/widgets/form_header.dart';
import 'package:automated_clinic_management_system/widgets/my_button.dart';
import 'package:automated_clinic_management_system/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

class LoginAdminScreen extends StatefulWidget {
  const LoginAdminScreen({super.key});

  @override
  LoginAdminScreenState createState() => LoginAdminScreenState();
}

class LoginAdminScreenState extends State<LoginAdminScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  // controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      await AuthService().loginUser(
        context: context,
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      setState(() {
        isLoading = false;
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {
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
                    // Back Button and Title
                    const FormHeader(text: "Admin Login"),

                    // Email Field
                    MyTextField(
                      controller: _emailController,
                      label: "Email",
                      keyboardType: TextInputType.emailAddress,
                      isRequired: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return "Please enter your Email";
                        if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value.trim())) {
                          return "Enter a valid email address";
                        }
                        return null;
                      },
                    ),

                    // Password Field
                    MyTextField(
                      controller: _passwordController,
                      label: "Password",
                      isPassword: true,
                      isRequired: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),
                    // Login Button
                    MyButton(
                      text: 'Login',
                      isPrimary: true,
                      onPressed: _login,
                    ),

                    const SizedBox(height: 10),
                    // Forgot Password
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/forgotPassword");
                      },
                      child: const Text("Forgot Password?", style: TextStyle(color: Colors.blue)),
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
