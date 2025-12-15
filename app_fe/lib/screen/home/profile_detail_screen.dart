// File: lib/screen/main/profile_detail_screen.dart

import 'package:app_fe/screen/home/mainscreen.dart';
import 'package:app_fe/screen/home/match_success_screen.dart';
import 'package:app_fe/screen/home/matches_screen.dart';
import 'package:flutter/material.dart';

class ProfileDetailScreen extends StatelessWidget {
  // Dữ liệu mô phỏng
  final Map<String, dynamic> profileData = {
    "name": "Alfredo Calzoni",
    "age": 20,
    "location": "HAMBURG, GERMANY",
    "match_percent": 80,
    "distance": 2.5,
    "about":
        "A good listener. I love having a good talk to know each other's side 🥰.",
    "interests": [
      {"label": "Nature", "icon": "🌿"},
      {"label": "Travel", "icon": "✈️"},
      {"label": "Writing", "icon": "📝"},
      {"label": "People", "icon": "🙂"},
      {"label": "Gym & Fitness", "icon": "💪"},
    ],
    "gender": "Male",
    "friends": 2759,
    "height": "175 cm",
    "languages": "German, English",
    "color": Color(0xFF5F0F40), // Màu tím đậm chủ đạo
  };

  // --- Widget Info Pill (Gender, Age, Friends) ---
  Widget _buildInfoPill({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color, size: 30),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // --- Widget Section Title ---
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  // --- Widget Attribute Row ---
  Widget _buildAttributeRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    final Color primaryRed = Color(0xFFFF5F6D);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: primaryRed, size: 20),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                Text(
                  value,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget Interest Chip ---
  Widget _buildInterestChip(Map<String, String> data) {
    final Color hintColor = Color(0xFFFF5F6D);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: EdgeInsets.only(right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(data['icon']!, style: TextStyle(fontSize: 16)),
          SizedBox(width: 6),
          Text(
            data['label']!,
            style: TextStyle(color: Colors.black87, fontSize: 14),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = profileData['color'];
    final Color primaryRed = Color(0xFFFF5F6D);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER (Ảnh và Thông tin cơ bản) ---
            Container(
              height: 450,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withOpacity(0.1), primaryColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                children: [
                  // Nút Back
                  Positioned(
                    top: 50,
                    left: 10,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreen()),
                        );
                      },
                    ),
                  ),
                  // Nút Share/Distance
                  Positioned(
                    top: 50,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${profileData['distance']} km',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  // Match Percentage
                  Positioned(
                    top: 150,
                    right: 50,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: primaryRed,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${profileData['match_percent']}% Match',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Tên và Location
                  Positioned(
                    bottom: 100,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${profileData['name']}, ${profileData['age']}',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          profileData['location'],
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Nút X và Heart (Fixed Position)
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildActionButton(
                          Icons.close,
                          Colors.grey.shade400,
                          () {},
                          size: 50,
                        ),
                        SizedBox(width: 20),
                        _buildActionButton(Icons.favorite, primaryRed, () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MatchSuccessScreen(),
                            ),
                          );
                        }, size: 70),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. About Section
                    _buildSectionTitle("About"),
                    Text(
                      profileData['about'],
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),

                    // 2. Interest Section
                    _buildSectionTitle("Interest"),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: profileData['interests']
                          .map<Widget>(_buildInterestChip)
                          .toList(),
                    ),
                    SizedBox(height: 30),

                    // 3. Info Pills (Gender, Age, Friends)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildInfoPill(
                          icon: Icons.male,
                          title: 'Gender',
                          subtitle: profileData['gender'],
                          color: primaryRed,
                        ),
                        _buildInfoPill(
                          icon: Icons.calendar_today,
                          title: 'Age',
                          subtitle: '${profileData['age']} years old',
                          color: primaryRed,
                        ),
                        _buildInfoPill(
                          icon: Icons.people,
                          title: 'Friend',
                          subtitle: profileData['friends'].toString(),
                          color: primaryRed,
                        ),
                      ],
                    ),
                    SizedBox(height: 30),

                    // 4. Alfredo's Info
                    _buildSectionTitle(
                      "${profileData['name'].split(' ').first}'s Info",
                    ),

                    _buildAttributeRow(
                      icon: Icons.edit,
                      title: "Height",
                      value: profileData['height'],
                    ),
                    _buildAttributeRow(
                      icon: Icons.record_voice_over,
                      title: "Speak",
                      value: profileData['languages'],
                    ),

                    SizedBox(height: 30),

                    // Match Meter
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.grey.shade400,
                        ),
                        SizedBox(width: 5),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.grey.shade400,
                        ),
                        SizedBox(width: 15),
                        Text(
                          "You & ${profileData['name'].split(' ').first} have ${profileData['match_percent']}% of matching",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- BODY (About, Interests, Info) ---

  // Helper cho nút X và Heart
  Widget _buildActionButton(
    IconData icon,
    Color color,
    VoidCallback onPressed, {
    required double size,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: color, size: size * 0.5),
        onPressed: onPressed,
      ),
    );
  }
}
