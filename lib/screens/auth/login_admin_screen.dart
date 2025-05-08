import 'package:automated_clinic_management_system/core/utils/constants.dart';
import 'package:automated_clinic_management_system/providers/auth_provider.dart';
import 'package:automated_clinic_management_system/widgets/form_header.dart';
import 'package:automated_clinic_management_system/widgets/my_button.dart';
import 'package:automated_clinic_management_system/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginAdminScreen extends StatefulWidget {
  const LoginAdminScreen({super.key});

  @override
  LoginAdminScreenState createState() => LoginAdminScreenState();
}

class LoginAdminScreenState extends State<LoginAdminScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool _isRemembered = false;

  // CONTROLLERS
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _onLoginPressed() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);
    final auth = context.read<AuthProvider>();

    await auth.login(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (!mounted) return;

    if (auth.errorMessage != null) {
      // Display error message in SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(auth.errorMessage!)),
      );
    } else if (auth.status == AuthStatus.authenticated) {
      // Navigate to dashboard if login is successful
      Navigator.pushReplacementNamed(context, '/dashboard');
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 30, right: 30),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Row(
              children: [
                // LEFT COLUMN: IMAGE
                Expanded(
                    flex: 1,
                    child: Image.asset("assets/images/auth/signIn.png")),

                // RIGHT COLUMN: FORM
                Expanded(
                  flex: 1,
                  child: Form(
                    key: _formKey,
                    child: Material(
                      elevation: 10,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            // borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const FormHeader(text: "LOGIN"),
                            const SizedBox(height: 7),
                            MyTextField(
                                controller: _emailController,
                                label: "Email",
                                keyboardType: TextInputType.emailAddress,
                                isRequired: true,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter your Email";
                                  }
                                  if (!RegExp(
                                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                      .hasMatch(value.trim())) {
                                    return "Enter a valid email address";
                                  }
                                  return null;
                                }),
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
                                  } else if (!RegExp(r'\d').hasMatch(value)) {
                                    return "Password must contain at least one number";
                                  } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                      .hasMatch(value)) {
                                    return "Password must contain at least one special character";
                                  }
                                  return null;
                                }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // CHECKBOX
                                Row(
                                  children: [
                                    Checkbox(
                                      activeColor: AppConstants.priColor,
                                      value: _isRemembered,
                                      onChanged: (val) {
                                        setState(
                                            () => _isRemembered = val ?? false);
                                      },
                                    ),
                                    const Text("Remember Me")
                                  ],
                                ),

                                // Forgot Password
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, "/forgotPassword");
                                  },
                                  child: const Text("Forgot Password?",
                                      style: TextStyle(
                                          color: AppConstants.secColor)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Login Button
                            MyButton(
                              text: isLoading ? "Logging you in.." : "Login",
                              isPrimary: true,
                              onPressed: isLoading ? null : _onLoginPressed,
                            ),

                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
