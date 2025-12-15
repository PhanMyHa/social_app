// File: lib/screen/main/discover_by_interest_screen.dart

import 'package:app_fe/screen/home/discover_screen.dart';
import 'package:app_fe/screen/home/home_screen.dart';
import 'package:app_fe/screen/home/matches_screen.dart';
import 'package:app_fe/screen/home/messages_screen.dart';
import 'package:app_fe/widget/navbar.dart';
import 'package:flutter/material.dart';
class DiscoverByInterestScreen extends StatefulWidget {
  @override
  _DiscoverByInterestScreenState createState() => _DiscoverByInterestScreenState();
}

class _DiscoverByInterestScreenState extends State<DiscoverByInterestScreen> {
  // Index 1 đại diện cho tab Discover/Explore trên Navbar
  int _selectedIndex = 1; 
  
  // Màu sắc chính
  final Color primaryRed = Color(0xFFFF5F6D);
  final Color primaryPurple = Color(0xFF5F0F40);

  // Dữ liệu mô phỏng các Sở thích và số lượng người quan tâm
  final List<Map<String, dynamic>> interestStats = [
    {"label": "Photography", "count": 3.2, "unit": "k", "level": 3, "color": Color(0xFFFF5F6D)},
    {"label": "Nature", "count": 9.8, "unit": "k", "level": 4, "color": Color(0xFFC371FF)},
    {"label": "Music", "count": 4.7, "unit": "k", "level": 3, "color": Color(0xFF9B59B6)},
    {"label": "Writing", "count": 379, "unit": "", "level": 2, "color": Color(0xFF5F0F40)},
    {"label": "Fashion", "count": 657, "unit": "", "level": 3, "color": Color(0xFFFF5F6D)},
    {"label": "Gaming", "count": 1.5, "unit": "k", "level": 5, "color": Color(0xFFC371FF)},
    {"label": "Football", "count": 8.1, "unit": "k", "level": 4, "color": Color(0xFF9B59B6)},
  ];

  // --- Widget Hiển thị Level Interest ---
  Widget _buildInterestLevel(int level, Color activeColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final bool isActive = index < level;
        return Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? activeColor.withOpacity(0.8) : Colors.grey.shade300,
            ),
          ),
        );
      }),
    );
  }

  // --- Widget Dòng Dữ liệu Sở thích ---
  Widget _buildInterestRow(Map<String, dynamic> data) {
    final String countText = data['unit'] == 'k' 
                             ? "${data['count'].toStringAsFixed(1)}${data['unit']}" 
                             : data['count'].toString();
    final Color itemColor = data['color'];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Interested in ${data['label']}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: itemColor,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    _buildInterestLevel(data['level'], itemColor),
                    SizedBox(width: 10),
                    Text(
                      "$countText people",
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 15),
          // Placeholder Ảnh/Biểu đồ
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }

  // --- Logic Navigation Navbar (Đảm bảo hoạt động) ---
  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    
    // Giả định chuyển về HomeFeedScreen (Index 0) hoặc DiscoverScreen (Index 1)
    if (index == 0) {
      // Ví dụ chuyển sang HomeFeedScreen
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeFeedScreen()));
    } else if (index == 1) {
      // Giữ trạng thái
    }
    setState(() => _selectedIndex = index);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.black),
    onPressed: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DiscoverScreen(),
        ),
      );
    },
  ),
        title: Text(
          "Discover by Interest",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: 'Popular',
                icon: Icon(Icons.keyboard_arrow_down, color: primaryRed),
                style: TextStyle(color: Colors.black, fontSize: 16),
                onChanged: (String? newValue) {
                  // Xử lý thay đổi sắp xếp
                },
                items: <String>['Popular', 'Newest', 'Alphabetical']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(color: Colors.grey[800])),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: interestStats.map(_buildInterestRow).toList(),
        ),
      ),
     

    );
  }
}