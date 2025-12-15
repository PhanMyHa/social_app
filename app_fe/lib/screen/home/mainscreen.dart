import 'package:app_fe/screen/home/discover_screen.dart';
import 'package:app_fe/screen/home/home_screen.dart';
import 'package:app_fe/screen/home/matches_screen.dart';
import 'package:app_fe/screen/home/messages_screen.dart';
import 'package:app_fe/widget/navbar.dart';
import 'package:flutter/material.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 4; // Messages

  final _screens =  [
    HomeFeedScreen(),
    DiscoverScreen(),
    SizedBox(), // Add
    MatchesScreen(),
    MessagesScreen(), // ❗ chỉ content
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_index],
      bottomNavigationBar: NavbarWidget(
        initialIndex: _index,
        onItemTapped: (i) {
          setState(() => _index = i);
        },
      ),
    );
  }
}
