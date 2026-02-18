import 'package:flutter/material.dart';
import 'home.dart';
import 'poselibrary.dart';
import 'progresspage.dart';
import 'userprofile.dart';
import 'real_time.dart';

/// Main layout of the application providing the navigation shell
class MainLayout extends StatefulWidget {
  final String userName;
  const MainLayout({super.key, this.userName = "Yogi"});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  // Current active index for the navigation bar
  int _currentIndex = 0;

  // List of screens to be displayed in the layout
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // Initializing the pages list with user-specific data
    _pages = [
      HomeScreen(userName: widget.userName),
      const PoseLibraryPage(),
      const YogaPracticePage(),
      const YogaProgressPage(),
      YogaProfilePage(userName: widget.userName),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using IndexedStack to maintain state across page switches
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: const Color(0xFF19331E),
        selectedItemColor: const Color(0xFF13EC37),
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        // Bottom navigation icons and labels
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), activeIcon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt_outlined), activeIcon: Icon(Icons.camera_alt), label: "AI"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), activeIcon: Icon(Icons.bar_chart), label: "Stats"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
