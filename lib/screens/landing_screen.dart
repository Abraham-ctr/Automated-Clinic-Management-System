import 'package:automated_clinic_management_system/core/utils/constants.dart';
import 'package:automated_clinic_management_system/core/utils/routes.dart';
import 'package:automated_clinic_management_system/widgets/my_button.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  LandingScreenState createState() => LandingScreenState();
}

class LandingScreenState extends State<LandingScreen> with SingleTickerProviderStateMixin {
  // Animation controller
  late final AnimationController _controller;
  late final Animation<double> _logoFadeAnimation;
  late final Animation<Offset> _textSlideAnimation;
  late final Animation<double> _buttonsFadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this, // Provides the TickerProvider
      duration: const Duration(seconds: 2),
    )..forward();

    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _textSlideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _buttonsFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 400),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Fade-in animation
              FadeTransition(
                opacity: _logoFadeAnimation,
                child: Image.asset(AppConstants.logo, height: 300),
              ),
        
              // Header text sliding animation
              SlideTransition(
                position: _textSlideAnimation,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome to Domi",
                      style: TextStyle(
                        color: AppConstants.priColor,
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Care",
                      style: TextStyle(
                        color: AppConstants.secColor,
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
        
              // Subtext fade-in animation
              FadeTransition(
                opacity: _buttonsFadeAnimation,
                child: const Text(
                  "Efficient. Simple. Reliable",
                  style: TextStyle(
                    color: AppConstants.darkGreyColor,
                    fontSize: 20,
                  ),
                ),
              ),
        
              const SizedBox(height: 40),
        
              // Buttons fade-in animation
              FadeTransition(
                opacity: _buttonsFadeAnimation,
                child: Column(
                  children: [
                    MyButton(
                      text: "Login",
                      isPrimary: true,
                      onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
                    ),
                    const SizedBox(height: 10),
                    MyButton(
                      text: "Register",
                      isPrimary: false,
                      onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
