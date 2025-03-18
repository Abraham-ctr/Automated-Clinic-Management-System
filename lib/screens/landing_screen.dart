import 'package:automated_clinic_management_system/utils/constants.dart';
import 'package:automated_clinic_management_system/utils/routes.dart';
import 'package:automated_clinic_management_system/widgets/my_button.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 400),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
        
              // logo
              Image.asset(AppConstants.logo),
        
              // header text
              const Text(
                "Welcome to Dominion University Clinic App",
                style: TextStyle(
                  color: AppConstants.blueColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
        
              // sub text
              const Text(
                "Efficient. Simple. Reliable",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
        
              const SizedBox(height: 40),
        
              // buttons
              Column(
                children: [
                  MyButton(text: "Login", isPrimary: true, onPressed: ()=> Navigator.pushNamed(context, AppRoutes.login),),
                  const SizedBox(height: 10),
                  MyButton(text: "Register", isPrimary: false, onPressed: () => Navigator.pushNamed(context, AppRoutes.register),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}