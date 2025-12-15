// File: lib/widget/onboarding_base.dart

import 'package:flutter/material.dart';

class OnboardingBase extends StatelessWidget {
  final int step;
  final int totalSteps;
  final String title;
  final Widget currentWidget;
  final VoidCallback? onNext;
  final bool showAppBarLeading;

  const OnboardingBase({
    Key? key,
    required this.step,
    required this.totalSteps,
    required this.title,
    required this.currentWidget,
    this.onNext,
    this.showAppBarLeading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    Color hintColor = Theme.of(context).hintColor;
    double progress = step / totalSteps;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: showAppBarLeading
            ? IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 30),
            Expanded(
              child: currentWidget,
            ),
            // Phần cố định ở dưới
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text tiến trình
                Text(
                  '$step/$totalSteps',
                  style: TextStyle(
                    fontSize: 16,
                    color: hintColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Nút Next
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: onNext,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Thanh tiến trình
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(hintColor),
            ),
            SizedBox(height: 40), // Khoảng cách cuối
          ],
        ),
      ),
    );
  }
}