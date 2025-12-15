// File: lib/onboarding_screen_1.dart

import 'package:flutter/material.dart';
import 'onboarding_screen_2.dart';
import 'onboarding_screen_3.dart';

class OnboardingScreen1 extends StatelessWidget {
  // Widget mô phỏng hình tròn đại diện cho người dùng
  Widget _buildUserCircle({
    required double size,
    required Color borderColor,
    required String name,
    required IconData icon,
    required Color iconColor,
    Alignment alignment = Alignment.center,
  }) {
    return Align(
      alignment: alignment,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.2),
              border: Border.all(color: borderColor, width: 3.0),
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: TextStyle(color: Colors.grey[700], fontSize: 12),
              ),
              SizedBox(width: 4),
              Icon(icon, color: iconColor, size: 12),
            ],
          ),
        ],
      ),
    );
  }

  // Widget mô phỏng điểm kết nối
  Widget _buildConnectionPoint({
    required IconData icon,
    required String text,
    required Alignment alignment,
  }) {
    return Align(
      alignment: alignment,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Color(0xFF9B59B6), size: 18),
          Text(text, style: TextStyle(color: Colors.grey[700], fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // Hình tròn Clara
                _buildUserCircle(
                  size: 100,
                  borderColor: Color(0xFFFF5F6D),
                  name: 'Clara',
                  icon: Icons.star,
                  iconColor: Color(0xFFFF5F6D),
                  alignment: Alignment(-0.5, -0.2),
                ),
                // Hình tròn You
                _buildUserCircle(
                  size: 80,
                  borderColor: Color(0xFF9B59B6),
                  name: 'You',
                  icon: Icons.flash_on,
                  iconColor: Color(0xFF9B59B6),
                  alignment: Alignment(0.6, -0.4),
                ),
                // Điểm kết nối Music
                _buildConnectionPoint(
                  icon: Icons.music_note,
                  text: 'Music',
                  alignment: Alignment(-0.1, -0.6),
                ),
                // Điểm kết nối Fashion
                _buildConnectionPoint(
                  icon: Icons.checkroom,
                  text: 'Fashion',
                  alignment: Alignment(0.6, 0.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 20.0,
            ),
            child: Column(
              children: [
                Text(
                  'Make friends with the people like you',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Interact with people with the same interest like you',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 40),
                // Nút "Continue" -> Chuyển sang màn hình 2
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OnboardingScreen2(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5F0F40), // Tím đậm
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Text "Sign In" -> Chuyển sang màn hình 3 (Login/Signup)
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OnboardingScreen3(),
                      ),
                    );
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF5F0F40),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
