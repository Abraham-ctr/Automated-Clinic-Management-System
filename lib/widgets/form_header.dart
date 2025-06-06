import 'package:automated_clinic_management_system/core/utils/constants.dart';
import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  const FormHeader({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppConstants.secColor,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.whiteColor),
              ),
              Positioned(
                left: 0,
                child: IconButton(
                  onPressed: onPressed,
                  icon: const Icon(Icons.arrow_back_ios,
                      color: AppConstants.whiteColor),
                  tooltip: "Go Back",
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: AppConstants.priColor,
        )
      ],
    );
  }
}
