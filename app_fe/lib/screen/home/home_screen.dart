// File: lib/screen/main/home_feed_screen.dart

import 'package:app_fe/screen/home/discover_screen.dart';
import 'package:app_fe/screen/home/home_swipe_screen.dart';
import 'package:app_fe/screen/home/matches_screen.dart';
import 'package:app_fe/screen/home/messages_screen.dart';
import 'package:app_fe/widget/navbar.dart';
import 'package:flutter/material.dart';

class HomeFeedScreen extends StatefulWidget {
  @override
  _HomeFeedScreenState createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  int _selectedIndex = 0; // Index cho Navbar

  // Dữ liệu mô phỏng cho Feed Cards
  final List<Map<String, dynamic>> feedItems = [
    {
      'topic': 'Travel',
      'emoji': '🌴',
      'question':
          'If you could live anywhere in the world, where would you pick?',
      'name': 'Miranda Kehlani',
      'location': 'STUTTGART',
      'color': Color(0xFFC371FF), // Tím
    },
    {
      'topic': 'Football',
      'emoji': '⚽',
      'question': 'Who do you think will win Euro 2020?',
      'name': 'Brandon Aminoff',
      'location': 'HAMBURG',
      'color': Color(0xFFFF5F6D), // Đỏ cam
    },
  ];

  // --- Widget Card (Câu hỏi) ---
  Widget _buildFeedCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: 250,
      decoration: BoxDecoration(
        color: item['color'].withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Nội dung chính
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    '${item['emoji']} ${item['topic']}',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                SizedBox(height: 15),
                Expanded(
                  child: Text(
                    item['question'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    // Placeholder ảnh đại diện
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item['location'],
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Các nút tương tác bên phải
          Positioned(
            right: 10,
            top: 50,
            bottom: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInteractionButton(
                  Icons.thumb_up,
                  Colors.white.withOpacity(0.2),
                ),
                _buildInteractionButton(
                  Icons.person,
                  Colors.white.withOpacity(0.2),
                ),
                _buildInteractionButton(
                  Icons.more_horiz,
                  Colors.white.withOpacity(0.2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionButton(IconData icon, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }

  // --- Widget Header (Stories & Tabs) ---
  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        // App Bar & Notifications
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'JustTangles',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.notifications_none, color: Colors.black),
            ],
          ),
        ),
        // Stories
        Container(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10),
            children: [
              _buildStoryCircle('My Story', hasAdd: true, isRedBorder: false),
              _buildStoryCircle('Selena', isRedBorder: true),
              _buildStoryCircle('Clara', isRedBorder: true),
              _buildStoryCircle('Fabian', isRedBorder: false),
              _buildStoryCircle('Gigi', isRedBorder: false),
            ],
          ),
        ),
        // Tabs
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            children: [
              _buildTabButton(
                context,
                'Make Friends',
                isSelected: true,
                onTap: () {},
              ),
              _buildTabButton(
                context,
                'Search Partners',
                isSelected: false,
                onTap: () {
                  // Chuyển sang màn hình Swiping
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeSwipeScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStoryCircle(
    String name, {
    bool hasAdd = false,
    required bool isRedBorder,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade300,
                  border: isRedBorder
                      ? Border.all(color: Color(0xFFFF5F6D), width: 2)
                      : Border.all(color: Colors.grey.shade400, width: 1),
                ),
              ),
              if (hasAdd)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Color(0xFFFF5F6D), width: 1),
                    ),
                    child: Icon(Icons.add, color: Color(0xFFFF5F6D), size: 14),
                  ),
                ),
            ],
          ),
          SizedBox(height: 5),
          Text(name, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildTabButton(
    BuildContext context,
    String text, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? Color(0xFFFFF7FB) : Colors.white,
            foregroundColor: isSelected ? Color(0xFFFF5F6D) : Colors.grey,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.symmetric(vertical: 12),
          ),
          child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: feedItems.map(_buildFeedCard).toList()),
            ),
          ),
        ],
      ),

      //      bottomNavigationBar: NavbarWidget(
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
