// File: lib/onboarding_photos_screen.dart

import 'package:app_fe/widget/onboarding_base.dart';
import 'package:flutter/material.dart';
import 'verification_dialog.dart';

class OnboardingPhotosScreen extends StatelessWidget {
  // Widget mô phỏng khung ảnh
  Widget _buildPhotoFrame(BuildContext context, {bool isMain = false}) {
    return Container(
      width: isMain ? 120 : 80,
      height: isMain ? 160 : 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade400, width: 1),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (!isMain)
            Icon(Icons.person, color: Colors.grey.shade500, size: 40),
          Positioned(
            bottom: 5,
            right: 5,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Theme.of(context).hintColor,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: Colors.white, size: 14),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return OnboardingBase(
      step: 5,
      totalSteps: 5,
      title: "Upload your photos",
      showAppBarLeading: true,
      currentWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hàng ảnh chính
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Khung ảnh chính lớn
              _buildPhotoFrame(context, isMain: true),
              SizedBox(width: 15),
              // Các ảnh phụ
              Column(
                children: [
                  _buildPhotoFrame(context),
                  SizedBox(height: 15),
                  _buildPhotoFrame(context),
                ],
              ),
              SizedBox(width: 15),
              Column(
                children: [
                  _buildPhotoFrame(context),
                  SizedBox(height: 15),
                  _buildPhotoFrame(context),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.camera_alt, color: primaryColor),
            label: Text(
              'Change Photos',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 50),
          // Nút "Next" -> Hiển thị dialog xác minh
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => VerificationDialog(),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Next',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),

      // Đặt onNext là null vì nút Next đã được xử lý riêng
    );
  }
}
