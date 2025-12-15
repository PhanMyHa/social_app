import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// ===== Colors =====
const Color backgroundColor = Color(0xFFFFFFFF); // Bar color
const Color buttonColor = Color(0xFFFFDFDF); // Selected button bg
const Color primaryColor = Color(0xFFFF741E); // Icon color

/// NavbarWidget (SMOOTH VERSION)
/// - Quản lý index nội bộ (KHÔNG controlled từ parent)
/// - Chỉ notify parent khi đổi tab
/// - Tránh rebuild làm reset animation
class NavbarWidget extends StatefulWidget {
  final int initialIndex; // chỉ dùng lúc init
  final ValueChanged<int> onItemTapped;

  const NavbarWidget({
    Key? key,
    this.initialIndex = 0,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  final GlobalKey<CurvedNavigationBarState> _navKey = GlobalKey();
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    // Icons KHÔNG phụ thuộc state → mượt hơn
    const items = <Widget>[
      Icon(Icons.home, size: 30, color: primaryColor),
      Icon(Icons.explore, size: 30, color: primaryColor),
      Icon(Icons.add_circle_outline, size: 36, color: primaryColor),
      Icon(Icons.people, size: 30, color: primaryColor),
      Icon(Icons.chat_bubble, size: 30, color: primaryColor),
    ];

    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      child: Container(
        // Shadow giúp cảm giác mượt hơn (như code 2)
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: CurvedNavigationBar(
          key: _navKey,
          index: _index,
          items: items,
          height: 60,
          color: backgroundColor,
          buttonBackgroundColor: buttonColor,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (i) {
            if (i == _index) return;
            setState(() => _index = i); // animate nội bộ → mượt
            widget.onItemTapped(i); // notify parent
          },
        ),
      ),
    );
  }
}

// ================== EXAMPLE USAGE ==================
// Scaffold extendBody: true
// body đổi theo index nhận từ NavbarWidget

class HomeWithNavbar extends StatefulWidget {
  const HomeWithNavbar({super.key});

  @override
  State<HomeWithNavbar> createState() => _HomeWithNavbarState();
}

class _HomeWithNavbarState extends State<HomeWithNavbar> {
  int _pageIndex = 0;

  final _pages = const <Widget>[
    Center(child: Text('Home', style: TextStyle(fontSize: 24))),
    Center(child: Text('Explore', style: TextStyle(fontSize: 24))),
    Center(child: Text('Add', style: TextStyle(fontSize: 24))),
    Center(child: Text('People', style: TextStyle(fontSize: 24))),
    Center(child: Text('Chat', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_pageIndex],
      bottomNavigationBar: NavbarWidget(
        initialIndex: _pageIndex,
        onItemTapped: (i) {
          setState(() => _pageIndex = i);
        },
      ),
    );
  }
}
