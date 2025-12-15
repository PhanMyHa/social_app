// File: lib/onboarding_name_screen.dart

import 'package:app_fe/widget/onboarding_base.dart';
import 'package:flutter/material.dart';
import 'onboarding_birthdate_screen.dart';

class OnboardingNameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OnboardingBase(
      step: 1,
      totalSteps: 5,
      title: "What's your name?",
      currentWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Nadia Lipsh', // Placeholder
              contentPadding: EdgeInsets.only(bottom: 5),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).hintColor,
                  width: 2,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).hintColor,
                  width: 2,
                ),
              ),
            ),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 150), // Khoảng cách mô phỏng vị trí
        ],
      ),
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OnboardingBirthdateScreen()),
        );
      },
    );
  }
}
