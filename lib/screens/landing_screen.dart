// ignore_for_file: prefer_const_constructors

import 'package:automated_clinic_management_system/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'register_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // background gradient
          // Container(
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [Colors.blue.shade900, Colors.blue.shade600 ],
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter
          //     )
          //   ),
          // ),

          // content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 450),
              child: Column(
                children: [
                  Spacer(),

                  // DU logo
                  Image.asset("assets/images/logo.png", height: 150,),

                  const SizedBox(height: 20),

                  const Text(
                    "Welcome to the University Clinic App",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 7),

                  const Text(
                    "Efficient. Simple. Reliable.",
                    style: TextStyle(
                      color: Colors.grey
                    ),
                  ),

                  const SizedBox(height: 45),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) => LoginScreen() )
                        );
                      }, // navigate to login page
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        backgroundColor: Color(0xFF2b1176),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      child: Text("Login"),
                    ),
                  ),

                  SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      }, // navigate to register page
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        side: BorderSide(color: Color(0XFFae9719), width: 2),
                        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Color(0xFF2b1176)
                        ),
                      )
                    ),
                  ),

                  Spacer()
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
