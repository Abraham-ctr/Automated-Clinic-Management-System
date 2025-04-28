import 'package:automated_clinic_management_system/providers/auth_provider.dart';
import 'package:automated_clinic_management_system/widgets/form_header.dart';
import 'package:automated_clinic_management_system/widgets/my_button.dart';
import 'package:automated_clinic_management_system/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> _onSendResetLinkPressed() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final auth = context.read<AuthProvider>();
    await auth.resetPassword(_emailController.text.trim());

    if (!mounted) return;

    final message = auth.errorMessage ?? "Password reset link sent!";
    final isError = auth.status == AuthStatus.error;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );

    setState(() => isLoading = false);
  }

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
                padding: const EdgeInsets.all(20),
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
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    // Back Button and Title
                    const FormHeader(text: "Forgot Password"),

                    // header text
                    const Text(
                      "Enter your email address to receive a password reset link.",
                      style: TextStyle(fontSize: 16,),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),
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
                    
                    const SizedBox(height: 20,),
                    // forgot password button
                    MyButton(
                      text: isLoading ? "Sending..." : "Reset",
                      onPressed: isLoading ? null : _onSendResetLinkPressed,
                      isPrimary: true,
                    )
                  ],
                ),
              )
            ),
          )
        ),
      ),
    );
  }
}
