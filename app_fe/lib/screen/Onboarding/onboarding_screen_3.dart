// File: lib/onboarding_screen_3.dart

import 'package:app_fe/screen/Auth/login_screen.dart';
import 'package:app_fe/screen/Auth/signup_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen3 extends StatelessWidget {
  // Widget mô phỏng đồ họa bản đồ/vị trí (Giữ nguyên)
  Widget _buildMapGraphic() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Vòng tròn ngoài cùng
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFFFFC371).withOpacity(0.5), width: 2),
            ),
          ),
          // Vòng tròn giữa
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFFC371).withOpacity(0.3),
            ),
          ),
          // Vòng tròn trung tâm
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFFC371).withOpacity(0.7),
            ),
          ),

          // Các điểm vị trí (Markers)
          _buildMapMarker(Alignment(0.8, -0.7), Colors.grey.withOpacity(0.5), null),
          _buildMapMarker(Alignment(-0.5, 0.9), Colors.grey.withOpacity(0.5), null),
          _buildMapMarker(Alignment(-0.9, -0.3), Colors.grey.withOpacity(0.5), null),
          _buildMapMarker(Alignment(0.5, 0.2), Colors.grey.withOpacity(0.5), null),
          // Icon đỏ
          _buildMapMarker(Alignment(0.0, -0.9), Color(0xFFFF5F6D), Icons.location_on), 
        ],
      ),
    );
  }

  // Helper cho các điểm vị trí trên bản đồ (Giữ nguyên)
  Widget _buildMapMarker(Alignment alignment, Color color, IconData? icon) {
    return Align(
      alignment: alignment,
      child: icon != null
          ? Icon(
              icon,
              color: color,
              size: 24,
            )
          : Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
            ),
    );
  }

  // Nút đăng nhập chung (Đã cập nhật để dùng style có thể thay đổi màu khi nhấn)
  Widget _buildLoginButton({
    required IconData icon,
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                // Hiệu ứng dễ thương: tối màu hơn một chút khi nhấn
                return backgroundColor == Colors.white 
                       ? Colors.grey.shade100 
                       : backgroundColor.withOpacity(0.9); 
              }
              return backgroundColor;
            },
          ),
          foregroundColor: MaterialStateProperty.all<Color>(textColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: backgroundColor == Colors.white
                  ? BorderSide(color: Colors.grey.shade300, width: 1.5)
                  : BorderSide.none,
            ),
          ),
          elevation: MaterialStateProperty.all<double>(0),
          overlayColor: MaterialStateProperty.all<Color>(
            backgroundColor == Colors.white 
              ? Colors.grey.withOpacity(0.1) 
              : Colors.white.withOpacity(0.15)
          ),
        ),
        icon: Icon(icon, color: textColor),
        label: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color(0xFF5F0F40); // Tím đậm
    Color accentColor = Color(0xFFFF5F6D); // Đỏ cam

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey[700]),
          onPressed: () {
            // Quay lại màn hình trước
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMapGraphic(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Column(
              children: [
                Text(
                  "Let's meeting new people around you",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 40),
                // Nút "Login with Phone"
                _buildLoginButton(
                  icon: Icons.phone,
                  text: 'Login with Phone',
                  backgroundColor: primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    // Xử lý chuyển sang màn hình Login Phone
                  },
                ),
                // Nút "Login with Google"
                _buildLoginButton(
                  icon: Icons.alternate_email, 
                  text: 'Login with Google',
                  backgroundColor: Colors.white,
                  textColor: Colors.grey[800]!,
                  onPressed: () {
                    // CHUYỂN TRANG: Đã sửa để dùng file import sẵn
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
                SizedBox(height: 20),
                // Text "Don't have an account? Sign Up"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    InkWell(
                      onTap: () {
                        // CHUYỂN TRANG: Đã sửa để dùng file import sẵn
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupScreen()),
                        );
                      },
                      // Thêm hiệu ứng dễ thương cho TextLink
                      borderRadius: BorderRadius.circular(5),
                      splashColor: accentColor.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
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