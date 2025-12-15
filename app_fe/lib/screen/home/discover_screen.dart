// File: lib/screen/main/discover_screen.dart (Thay thế cho Explore/Swiping Screen)

import 'package:app_fe/screen/home/discover_by_interest_screen.dart';
import 'package:app_fe/screen/home/filters_screen.dart';
import 'package:app_fe/screen/home/home_screen.dart';
import 'package:app_fe/screen/home/matches_screen.dart';
import 'package:app_fe/screen/home/messages_screen.dart';
import 'package:app_fe/widget/navbar.dart';
import 'package:flutter/material.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  // Index 1 đại diện cho tab Discover/Explore trên Navbar
  int _selectedIndex = 1;

  // Màu sắc chính
  final Color primaryRed = Color(0xFFFF5F6D);
  final Color primaryPurple = Color(0xFF5F0F40);
  final Color mapCircleColor = Color(0xFFC371FF);

  // 1. Dữ liệu cho Interests
  final List<Map<String, dynamic>> interestsData = [
    {"label": "Football", "icon": Icons.sports_soccer, "isSelected": false},
    {"label": "Nature", "icon": Icons.eco, "isSelected": false},
    {"label": "Language", "icon": Icons.language, "isSelected": false},
    {"label": "Photography", "icon": Icons.camera_alt, "isSelected": false},
    {
      "label": "Music",
      "icon": Icons.music_note,
      "isSelected": true,
    }, // Đang được chọn
    {"label": "Writing", "icon": Icons.edit, "isSelected": false},
  ];

  // 2. Dữ liệu cho phần Discover Cards
  final List<Map<String, dynamic>> discoverData = [
    {
      "name": "Halima, 19",
      "location": "BERLIN",
      "distance": "16 km away",
      "color": Colors.black,
      "new": true,
    },
    {
      "name": "Vanessa, 18",
      "location": "MUNICH",
      "distance": "4.8 km away",
      "color": Colors.black,
      "new": true,
    },
    {
      "name": "James, 20",
      "location": "HANOVER",
      "distance": "2.2 km away",
      "color": Colors.black,
      "new": true,
    },
  ];

  // Dữ liệu cho khu vực "Around Me"
  final Map<String, dynamic> aroundMeData = {
    "focusInterest": "Music",
    "people": [
      {
        "name": "Clara",
        "match": true,
        "alignment": Alignment(-0.35, -0.1),
      }, // Người chính
    ],
  };

  // --- Widget Build Discovery Cards ---
  Widget _buildDiscoverCard(Map<String, dynamic> data) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            data['color'].withOpacity(0.1),
            data['color'].withOpacity(0.6),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          // Label NEW
          if (data['new'])
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: primaryRed,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'NEW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          // Distance
          Positioned(
            top: 40,
            left: 10,
            child: Text(
              data['distance'],
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          // Name and Location
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
        ],
      ),
    );
  }

  // --- Widget Build Interest Chips ---
  Widget _buildInterestChip(Map<String, dynamic> item) {
    final bool isSelected = item['isSelected'];
    final Color selectedBg = primaryRed;
    final Color selectedFg = Colors.white;
    final Color defaultFg = primaryRed;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: isSelected ? selectedBg : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isSelected ? selectedBg : Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            item['icon'],
            size: 18,
            color: isSelected ? selectedFg : defaultFg,
          ),
          SizedBox(width: 6),
          Text(
            item['label'],
            style: TextStyle(
              color: isSelected ? selectedFg : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Cho phép modal chiếm gần hết màn hình
      backgroundColor: Colors
          .transparent, // Đặt transparent để FiltersScreen định nghĩa background
      builder: (context) {
        // Vì FiltersScreen là StatefulWidget và có SingleChildScrollView,
        // nó sẽ tự xử lý padding bottom để tránh bị bàn phím che.
        return FiltersScreen();
      },
    );
  }

  // --- Widget Map (Around Me) ---
  Widget _buildAroundMeMap(BuildContext context) {
    return Container(
      height: 300,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Placeholder Map Image (Mô phỏng)
          Center(
            child: Text(
              'Map Placeholder',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),

          // Vòng tròn lớn (Vị trí người dùng hoặc khu vực tìm kiếm)
          Align(
            alignment: aroundMeData['people'][0]['alignment'],
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: mapCircleColor.withOpacity(0.2),
                border: Border.all(
                  color: mapCircleColor.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: Center(
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white, // Ảnh profile ở đây
                  ),
                ),
              ),
            ),
          ),

          // Bubble "Connect with Clara"
          Positioned(
            top: 50, // Điều chỉnh vị trí tương đối
            left: 50,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: primaryPurple,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(Icons.wifi, color: Colors.white, size: 14),
                  SizedBox(width: 4),
                  Text(
                    'Connect with Clara',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Icon(
                    Icons.flash_on,
                    color: Colors.yellow,
                    size: 14,
                  ), // Icon tia sét
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Top Bar (Location, Discover, Icons) ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: primaryRed, size: 20),
                        Text(
                          'Germany',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down, color: Colors.black),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.search, size: 28),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.tune, size: 28),
                          onPressed: () {
                            _showFilters(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Discover',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),

                // --- Discover Cards List ---
                Container(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: discoverData.map(_buildDiscoverCard).toList(),
                  ),
                ),
                SizedBox(height: 30),

                // --- Interests Section ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Interest',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DiscoverByInterestScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'View all',
                        style: TextStyle(
                          color: primaryRed,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),

                // Interest Chips List
                Container(
                  height: 45,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: interestsData.map(_buildInterestChip).toList(),
                  ),
                ),
                SizedBox(height: 30),

                // --- Around Me Section ---
                Text(
                  'Around me',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  'People with "${aroundMeData['focusInterest']}" interest around you',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                _buildAroundMeMap(context),
                SizedBox(height: 30),
              ],
            ),
          ),
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
