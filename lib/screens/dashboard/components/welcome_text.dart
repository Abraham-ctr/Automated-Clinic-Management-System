import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:automated_clinic_management_system/providers/user_profile_provider.dart'; // UserProvider

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing the UserProvider using Consumer
    return Consumer<UserProfileProvider>(
      builder: (context, userProvider, child) {
        // Fetch user data if it's not already fetched
        if (userProvider.isLoading) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (userProvider.hasError) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: Text('Failed to load user data. Please try again later.', style: TextStyle(color: Colors.red))),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Welcome, ${userProvider.role} ${userProvider.firstName}!',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Registration Number: ${userProvider.regNumber}',
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
