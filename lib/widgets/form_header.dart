import 'package:automated_clinic_management_system/utils/constants.dart';
import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final String text;

  const FormHeader({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // color: Colors.green,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: AppConstants.goldColor),
              ),
        
              Positioned(
                left: 0,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20,)
      ],
    );
  }
}
