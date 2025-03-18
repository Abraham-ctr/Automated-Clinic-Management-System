import 'package:flutter/material.dart';
import 'package:automated_clinic_management_system/services/auth_service.dart';

class WelcomeText extends StatefulWidget {
  const WelcomeText({super.key});

  @override
  State<WelcomeText> createState() => _WelcomeTextState();
}

class _WelcomeTextState extends State<WelcomeText> {
  String? firstName;
  String? regNumber;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // Fetch current user data
  Future<void> _fetchUserData() async {
    Map<String, dynamic>? userData = await AuthService().getUserData(context);

    if (userData != null) {
      setState(() {
        firstName = userData['firstName'];
        regNumber = userData['regNumber'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          isLoading
              ? const CircularProgressIndicator() // Show loading indicator while fetching data
              : Column(
                  children: [
                    Text(
                      'Welcome, ${firstName ?? "User"}!',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Registration Number: ${regNumber ?? "Not available"}',
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
