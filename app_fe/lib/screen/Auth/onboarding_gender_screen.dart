// File: lib/onboarding_gender_screen.dart

import 'package:app_fe/widget/onboarding_base.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'onboarding_interests_screen.dart';

class OnboardingGenderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OnboardingBase(
      step: 3,
      totalSteps: 5,
      title: "What is your gender?",
      showAppBarLeading: true,
      currentWidget: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Lựa chọn Man (Không được chọn trong ảnh)
              _buildGenderOption(
                context,
                icon: FontAwesomeIcons.mars,
                label: 'Man',
                isSelected: false,
              ),
              // Lựa chọn Woman (Được chọn trong ảnh)
              _buildGenderOption(
                context,
                icon: FontAwesomeIcons.venus,
                label: 'Woman',
                isSelected: true,
              ),
            ],
          ),
        ],
      ),
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OnboardingInterestsScreen()),
        );
      },
    );
  }

  Widget _buildGenderOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    Color selectedColor = Theme.of(context).hintColor;
    Color defaultColor = Colors.grey.shade300;

    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: isSelected ? selectedColor.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isSelected ? selectedColor : defaultColor,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Icon(
                icon,
                size: 50,
                color: isSelected ? selectedColor : Colors.grey[700],
              ),
              if (isSelected)
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.check_circle,
                    color: selectedColor,
                    size: 16,
                  ),
                ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected ? selectedColor : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
