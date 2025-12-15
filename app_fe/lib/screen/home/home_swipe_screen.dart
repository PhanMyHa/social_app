import 'package:app_fe/screen/home/discover_screen.dart';
import 'package:app_fe/screen/home/home_screen.dart';
import 'package:app_fe/screen/home/matches_screen.dart';
import 'package:app_fe/screen/home/messages_screen.dart';
import 'package:app_fe/widget/navbar.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

class HomeSwipeScreen extends StatefulWidget {
  @override
  _HomeSwipeScreenState createState() => _HomeSwipeScreenState();
}

class _HomeSwipeScreenState extends State<HomeSwipeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> profiles = [
    {
      'name': 'Alfredo Calzoni, 20',
      'location': 'HAMBURG, GERMANY',
      'match': 80,
      'color': Color(0xFF9B59B6).withOpacity(0.85),
      'distance': '2.5 km away',
      'instagram': '@alfredotravels',
      'twitter': '@alcal',
    },
    {
      'name': 'Alfonso Gouse, 23',
      'location': 'HANOVER, GERMANY',
      'match': 80,
      'color': Colors.grey.shade800.withOpacity(0.85),
      'distance': '16.8 km away',
      'instagram': '@alfonsosnap',
      'twitter': '@gouseX',
    },
    {
      'name': 'Miranda Kehlani, 21',
      'location': 'STUTTGART, GERMANY',
      'match': 75,
      'color': Color(0xFFFF5F6D).withOpacity(0.85),
      'distance': '5.1 km away',
      'instagram': '@mirandak',
      'twitter': '@kmi',
    },
  ];

  late MatchEngine _matchEngine;
  late List<SwipeItem> _swipeItems;

  @override
  void initState() {
    super.initState();

    _swipeItems = profiles.map((profile) {
      return SwipeItem(
        content: profile,
        likeAction: () {},
        nopeAction: () {},
        superlikeAction: () {},
      );
    }).toList();

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  // ================= CARD UI (GIỮ NGUYÊN THIẾT KẾ CỦA BẠN) =================
  Widget _buildProfileCard(
      BuildContext context, Map<String, dynamic> profileData) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  profileData['color'].withOpacity(0.2),
                  profileData['color'],
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Distance + Match
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _pill(profileData['distance']),
                _pill('${profileData['match']}%', light: true),
              ],
            ),
          ),

          // Bottom info
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profileData['name'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  profileData['location'],
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.person, color: Colors.white, size: 18),
                    SizedBox(width: 4),
                    Text(profileData['twitter'],
                        style: TextStyle(color: Colors.white)),
                    SizedBox(width: 15),
                    Icon(Icons.camera_alt,
                        color: Colors.white, size: 18),
                    SizedBox(width: 4),
                    Text(profileData['instagram'],
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pill(String text, {bool light = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: light
            ? Colors.white.withOpacity(0.9)
            : Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: light ? Colors.black : Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ================= BUILD =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildCustomAppBar(),

            // 🔥 PHẦN SWIPE THẬT
            Expanded(
              child: SwipeCards(
                matchEngine: _matchEngine,
                itemBuilder: (context, index) {
                  return _buildProfileCard(
                      context, profiles[index]);
                },
                onStackFinished: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Hết người để vuốt")),
                  );
                },
                upSwipeAllowed: true,
                fillSpace: true,
              ),
            ),

            _buildBottomButtons(),
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

  // ================= BOTTOM BUTTONS =================
  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _circleButton(Icons.close, Colors.grey.shade400,
              () => _matchEngine.currentItem?.nope()),
          _circleButton(Icons.star, Color(0xFF9B59B6),
              () => _matchEngine.currentItem?.superLike(),
              size: 70),
          _circleButton(Icons.favorite, Color(0xFFFF5F6D),
              () => _matchEngine.currentItem?.like()),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon, Color color, VoidCallback onTap,
      {double size = 50}) {
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
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: color, size: size * 0.5),
        onPressed: onTap,
      ),
    );
  }

  // ================= HEADER + APP BAR (GIỮ NGUYÊN) =================
  // 👉 mình giữ nguyên logic của bạn (rút gọn cho đỡ dài)
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
                isSelected: false,
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeFeedScreen()),
                  );
                },
              ),
              _buildTabButton(
                context,
                'Search Partners',
                isSelected: true,
                onTap: () {
                  // Chuyển sang màn hình Swiping
                },
              ),
            ],
          ),
        ),
      ],
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
  Widget _buildCustomAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 1. Icon ảnh đại diện/profile (Trái)
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade300,
            ),
          ),

          // 2. Icon trái tim & Icon lọc (Giữa & Phải)
          Row(
            children: [
              // Icon Trái Tim (Matches/Likes)
              Stack(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.grey[700],
                      size: 28,
                    ),
                    onPressed: () {},
                  ),
                  // Chấm đỏ thông báo
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Color(0xFFFF5F6D), // Màu đỏ cam
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10),
              // Icon Lọc/Cài đặt (Phải)
              IconButton(
                icon: Icon(
                  Icons.tune,
                  color: Colors.grey[700],
                  size: 28,
                ), // Icon lọc (filter/tune)
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
