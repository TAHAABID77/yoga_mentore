import 'package:flutter/material.dart';
import 'home.dart';
import 'poselibrary.dart';
import 'progresspage.dart';
import 'userprofile.dart';
import 'real_time.dart';

/// App ka Main Layout jo tabs aur navigation ko handle krta hai
class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  // Current active index for the navigation bar - Konsa tab khula hua hai
  int _currentIndex = 0;

  // List of screens - Tabs ke liye pages ki list
  final List<Widget> _pages = [
    const HomeScreen(),
    const PoseLibraryPage(),
    const YogaPracticePage(),
    const YogaProgressPage(),
    const YogaProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack use kr rahay hain taake tabs switch krte waqt state loss na ho
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          // Tab switch krne par UI update krne ke liye setState
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(
          context,
        ).textTheme.bodySmall?.color?.withValues(alpha: 0.5),
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        // Navigation items: Home, Library, AI Practice, Stats, aur Profile
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_outlined),
            activeIcon: Icon(Icons.camera_alt),
            label: "AI Practice",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: "Progress",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
