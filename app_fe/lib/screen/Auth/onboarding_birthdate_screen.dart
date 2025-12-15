// File: lib/onboarding_birthdate_screen.dart

import 'package:app_fe/widget/onboarding_base.dart';
import 'package:flutter/material.dart';
import 'onboarding_gender_screen.dart';

class OnboardingBirthdateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OnboardingBase(
      step: 2,
      totalSteps: 5,
      title: "When is your birthdate?",
      showAppBarLeading: true, // Hiển thị nút back
      currentWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: '20/10/20', // Placeholder
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
            keyboardType: TextInputType.none, // Vô hiệu hóa bàn phím mặc định
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 40),
          // Bàn phím số mô phỏng
          _buildNumberPad(context),
        ],
      ),
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OnboardingGenderScreen()),
        );
      },
    );
  }

  Widget _buildNumberPad(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 50),
      child: Column(
        children: [
          _buildNumberRow(['1', '2', '3']),
          _buildNumberRow(['4', '5', '6']),
          _buildNumberRow(['7', '8', '9']),
          _buildNumberRow(['', '0', 'delete']),
        ],
      ),
    );
  }

  Widget _buildNumberRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: keys.map((key) {
        if (key == '') {
          return SizedBox(width: 80, height: 60); // Ô trống
        }
        if (key == 'delete') {
          return IconButton(
            icon: Icon(Icons.backspace_outlined, size: 28, color: Colors.grey),
            onPressed: () {},
          );
        }
        return Container(
          alignment: Alignment.center,
          width: 80,
          height: 60,
          child: Text(
            key,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        );
      }).toList(),
    );
  }
}
