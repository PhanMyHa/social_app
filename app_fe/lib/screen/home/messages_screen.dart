// File: lib/screen/main/messages_screen.dart

import 'package:app_fe/screen/home/chat_screen.dart';
import 'package:app_fe/screen/home/discover_screen.dart';
import 'package:app_fe/screen/home/home_screen.dart';
import 'package:app_fe/screen/home/matches_screen.dart';
import 'package:app_fe/widget/navbar.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  // Index 4 đại diện cho tab Messages trên Navbar
  int _selectedIndex = 4;

  // Màu sắc chính
  final Color primaryRed = Color(0xFFFF5F6D);
  final Color primaryPurple = Color(0xFF5F0F40);
  final Color lightPurple = Color(0xFFFFF7FB);

  // Dữ liệu mô phỏng Recent Matches (Giả định Matches là 32)
  final List<Map<String, dynamic>> recentMatches = [
    {"name": "Likes", "count": 32, "isHeart": true, "color": Color(0xFF9B59B6)},
    {
      "name": "Match 1",
      "count": 0,
      "isHeart": false,
      "color": Colors.grey.shade300,
    },
    {
      "name": "Match 2",
      "count": 0,
      "isHeart": false,
      "color": Colors.grey.shade300,
    },
    {
      "name": "Match 3",
      "count": 0,
      "isHeart": false,
      "color": Colors.grey.shade300,
    },
    {
      "name": "Match 4",
      "count": 0,
      "isHeart": false,
      "color": Colors.grey.shade300,
    },
  ];

  // Dữ liệu mô phỏng Recent Messages
  final List<Map<String, dynamic>> recentMessages = [
    {
      "name": "Alfredo Calzoni",
      "message": "What about that new jacket if I ...",
      "time": "09:18",
      "isOnline": true,
    },
    {
      "name": "Clara Hazel",
      "message": "I know right 😊",
      "time": "12:44",
      "isOnline": false,
    },
    {
      "name": "Brandon Aminoff",
      "message": "I've already registered, can't wai...",
      "time": "08:06",
      "isOnline": true,
    },
    {
      "name": "Amina Mina",
      "message": "It will have two lines of heading ...",
      "time": "09:32",
      "isOnline": false,
    },
    {
      "name": "Alfredo Calzoni",
      "message": "What about that new jacket if I ...",
      "time": "09:18",
      "isOnline": true,
    },
    {
      "name": "Clara Hazel",
      "message": "I know right 😊",
      "time": "12:44",
      "isOnline": false,
    },
    {
      "name": "Brandon Aminoff",
      "message": "I've already registered, can't wai...",
      "time": "08:06",
      "isOnline": true,
    },
    {
      "name": "Amina Mina",
      "message": "It will have two lines of heading ...",
      "time": "09:32",
      "isOnline": false,
    },
  ];

  // --- Widget Recent Match Circle ---
  Widget _buildMatchCircle(Map<String, dynamic> data) {
    return Container(
      width: 70,
      height: 70,
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: data['isHeart'] ? data['color'].withOpacity(0.8) : data['color'],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: data['isHeart']
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite, color: Colors.white, size: 28),
                  Text(
                    data['count'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : Container(), // Placeholder cho ảnh profile
      ),
    );
  }

  // --- Widget Message Row ---
  Widget _buildMessageRow(Map<String, dynamic> data) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen()),
                  );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder Ảnh đại diện
            Stack(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade300,
                  ),
                ),
                if (data['isOnline'])
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryRed, // Màu đỏ cho trạng thái Online
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 15),
            // Nội dung tin nhắn
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['name'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    data['message'],
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Thời gian
            Text(
              data['time'],
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }

  // --- Logic Navigation Navbar ---
  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    // Giả định chuyển về các màn hình chính khác
    // Thêm logic navigation thực tế tại đây

    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ===== PHẦN TRÊN (NỀN TÍM) =====
          Container(
            color: primaryPurple,
            child: SafeArea(
              bottom: false, // rất quan trọng
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Text(
                          'Messages',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 40),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Recent Matches
                  SizedBox(
                    height: 70,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: recentMatches.map(_buildMatchCircle).toList(),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // ===== PHẦN DƯỚI (TRẮNG) =====
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.only(top: 20),
                children: recentMessages.map(_buildMessageRow).toList(),
              ),
            ),
          ),
        ],
      ),
    );

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
  }
}
