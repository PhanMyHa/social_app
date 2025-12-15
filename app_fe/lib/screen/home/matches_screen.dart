// File: lib/screen/main/matches_screen.dart

import 'package:app_fe/screen/home/account_profile_screen.dart';
import 'package:app_fe/screen/home/discover_screen.dart';
import 'package:app_fe/screen/home/home_screen.dart';
import 'package:app_fe/screen/home/messages_screen.dart';
import 'package:app_fe/screen/home/profile_detail_screen.dart';
import 'package:app_fe/widget/navbar.dart';
import 'package:flutter/material.dart';

class MatchesScreen extends StatefulWidget {
  @override
  _MatchesScreenState createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  // Index 3 đại diện cho tab Matches/People trên Navbar
  int _selectedIndex = 3;

  // Màu sắc chính
  final Color primaryRed = Color(0xFFFF5F6D);
  final Color primaryPurple = Color(0xFF5F0F40);

  // Dữ liệu mô phỏng các Matches
  final List<Map<String, dynamic>> matchData = [
    {
      "name": "James, 20",
      "location": "HANOVER",
      "distance": "1.3 km away",
      "match_percent": 100,
      "color": Color(0xFF5F0F40),
    },
    {
      "name": "Eddie, 23",
      "location": "DORTMUND",
      "distance": "2 km away",
      "match_percent": 94,
      "color": Colors.grey,
    },
    {
      "name": "Brandon, 20",
      "location": "HANOVER",
      "distance": "2.5 km away",
      "match_percent": 89,
      "color": Colors.grey,
    },
    {
      "name": "Alfredo, 20",
      "location": "DORTMUND",
      "distance": "2.5 km away",
      "match_percent": 80,
      "color": Colors.grey,
    },
    {
      "name": "Clara, 19",
      "location": "BERLIN",
      "distance": "1.5 km away",
      "match_percent": 72,
      "color": Colors.grey,
    },
    {
      "name": "Fabian, 21",
      "location": "MUNICH",
      "distance": "3 km away",
      "match_percent": 68,
      "color": Colors.grey,
    },
  ];

  // --- Widget Thống kê Likes/Connects ---
  Widget _buildStatPill({
    required IconData icon,
    required String label,
    required int count,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.1),
            border: Border.all(color: color.withOpacity(0.5), width: 2),
          ),
          child: Icon(icon, color: color, size: 36),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  // --- Widget Match Card trong Grid ---
  Widget _buildMatchCard(Map<String, dynamic> data) {
    final Color topColor = data['color'] == Colors.grey
        ? primaryRed
        : primaryPurple;
    final bool isDarkBackground = data['color'] != Colors.grey;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfileDetailScreen()),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade300, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: [
                // Placeholder Ảnh
                Container(color: Colors.grey.shade300),

                // Gradient ở dưới (Nơi chứa text)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          primaryPurple.withOpacity(0.9),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.5, 1.0],
                      ),
                    ),
                  ),
                ),

                // Metadata
                Positioned(
                  bottom: 15,
                  left: 15,
                  right: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['distance'],
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            data['name'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryRed,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        data['location'],
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                // Match Percentage Banner (Top Right)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: topColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    child: Text(
                      '${data['match_percent']}% Match',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Logic Navigation Navbar ---
  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    // Xử lý chuyển trang giữa các màn hình chính (Giả định HomeFeedScreen là index 0)
    // Nếu bạn muốn navigation đầy đủ, cần thêm logic cho index 0, 1, 2, 4
    // Ví dụ: if (index == 0) { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeFeedScreen())); }

    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context), // Quay lại màn hình trước
        ),
        title: Text(
          "Matches",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: const Color.fromARGB(255, 172, 5, 144),size: 40,),
            onPressed: () {
              Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AccountProfileScreen()),
                  );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),

            // --- Likes & Connects Stats ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatPill(
                  icon: Icons.favorite,
                  label: "Likes",
                  count: 32,
                  color: primaryRed,
                ),
                _buildStatPill(
                  icon: Icons.chat_bubble,
                  label: "Connect",
                  count: 15,
                  color: primaryPurple,
                ),
              ],
            ),
            SizedBox(height: 30),

            // --- Your Matches Title ---
            Text(
              "Your Matches 47",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),

            // --- Matches Grid ---
            GridView.builder(
              physics:
                  NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn trong GridView
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.75, // Tỷ lệ chiều rộng/chiều cao
              ),
              itemCount: matchData.length,
              itemBuilder: (context, index) {
                return _buildMatchCard(matchData[index]);
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
      //       bottomNavigationBar: NavbarWidget(
      //   selectedIndex: _selectedIndex,
      //   onItemTapped: (index) {
      //     if (index == _selectedIndex) return;

      //     setState(() {
      //       _selectedIndex = index;
      //     });

      //     switch (index) {
      //       case 0:
      //         Navigator.pushReplacement(
      //           context,
      //           MaterialPageRoute(builder: (_) => HomeFeedScreen()),
      //         );
      //         break;

      //       case 1:
      //         Navigator.pushReplacement(
      //           context,
      //           MaterialPageRoute(builder: (_) => DiscoverScreen()),
      //         );
      //         break;

      //       case 3:
      //         Navigator.pushReplacement(
      //           context,
      //           MaterialPageRoute(builder: (_) => MatchesScreen()),
      //         );
      //         break;

      //       case 4:
      //         Navigator.pushReplacement(
      //           context,
      //           MaterialPageRoute(builder: (_) => MessagesScreen()),
      //         );
      //         break;

      //       default:
      //         break;
      //     }
      //   },
      // ),
    );
  }
}
