// File: lib/onboarding_interests_screen.dart

import 'package:app_fe/widget/onboarding_base.dart';
import 'package:flutter/material.dart';
import 'onboarding_photos_screen.dart';


class OnboardingInterestsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> interests = [
    {'label': 'Language', 'icon': Icons.language, 'isSelected': false},
    {'label': 'Music', 'icon': Icons.music_note, 'isSelected': true},
    {'label': 'Movie', 'icon': Icons.movie, 'isSelected': true},
    {'label': 'Photography', 'icon': Icons.photo_camera, 'isSelected': true},
    {'label': 'Book', 'icon': Icons.book, 'isSelected': true},
    {'label': 'Fashion', 'icon': Icons.checkroom, 'isSelected': true},
    {'label': 'Gaming', 'icon': Icons.gamepad, 'isSelected': false},
    {'label': 'Dancing', 'icon': Icons.accessibility_new, 'isSelected': false},
    {'label': 'Architecture', 'icon': Icons.apartment, 'isSelected': false},
    {'label': 'Writing', 'icon': Icons.edit, 'isSelected': false},
    {'label': 'Nature', 'icon': Icons.park, 'isSelected': false},
    {'label': 'Painting', 'icon': Icons.palette, 'isSelected': false},
    {'label': 'Football', 'icon': Icons.sports_soccer, 'isSelected': false},
    {'label': 'People', 'icon': Icons.people, 'isSelected': false},
    {'label': 'Animals', 'icon': Icons.pets, 'isSelected': true},
    {'label': 'Gym & Fitness', 'icon': Icons.fitness_center, 'isSelected': false},
  ];

  @override
  Widget build(BuildContext context) {
    return OnboardingBase(
      step: 4,
      totalSteps: 5,
      title: "Select up to 5 Interests",
      showAppBarLeading: true,
      currentWidget: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: interests.map((item) {
              return _buildInterestChip(
                context,
                label: item['label'],
                icon: item['icon'],
                isSelected: item['isSelected'],
              );
            }).toList(),
          ),
        ),
      ),
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OnboardingPhotosScreen()),
        );
      },
    );
  }

  Widget _buildInterestChip(BuildContext context, {
    required String label,
    required IconData icon,
    required bool isSelected,
  }) {
    Color selectedColor = Theme.of(context).hintColor;
    Color defaultColor = Colors.grey.shade300;
    Color textColor = isSelected ? Colors.white : Colors.grey.shade700;

    return Chip(
      avatar: Icon(
        icon,
        size: 16,
        color: textColor,
      ),
      label: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      backgroundColor: isSelected ? selectedColor : defaultColor.withOpacity(0.5),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide.none,
      ),
    );
  }
}