import 'package:flutter/material.dart';
import 'package:yoga_mentore/Screens/splash.dart';
import 'package:yoga_mentore/Screens/loginsignup.dart';
import 'package:yoga_mentore/Screens/userprofile.dart';
import 'package:yoga_mentore/Screens/poselibrary.dart';
import 'package:yoga_mentore/Screens/main_layout.dart';
import 'package:yoga_mentore/Screens/progresspage.dart';
import 'package:yoga_mentore/Screens/real_time.dart';

void main() {
  // Ensures that widget binding is initialized before calling runApp
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

/// The main application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yoga Mentor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Defining the primary color theme for the application
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF13EC5B)),
        useMaterial3: true,
        // Setting a dark theme aesthetic for the app
        scaffoldBackgroundColor: const Color(0xFF102213),
      ),
      // Initial screen of the application
      home: const SplashScreen(),
      // Named routes for navigation across the app
      routes: {
        '/login': (context) => const AuthScreen(),
        '/home': (context) => const MainLayout(),
        '/Explore': (context) => const PoseLibraryPage(),
        '/Profile' : (context) => const YogaProfilePage(),
        '/Stats' : (context) => const YogaProgressPage(),
        '/AI' : (context) => const YogaPracticePage(),
      },
    );
  }
}
