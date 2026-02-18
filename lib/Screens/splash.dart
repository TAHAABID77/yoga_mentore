import 'package:flutter/material.dart';
import 'package:yoga_mentore/Screens/loginsignup.dart';

/// Animated splash screen that appears when the app starts
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progress;

  @override
  void initState() {
    super.initState();

    // Initializing the animation controller with a 3-second duration
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Creating a tween animation for the progress bar
    _progress = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {}); // Rebuild UI on每一帧 animation
      })
      ..addStatusListener((status) {
        // Navigate to AuthScreen once animation completes
        if (status == AnimationStatus.completed) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const AuthScreen()),
          );
        }
      });

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    // Dispose controller to prevent memory leaks
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Background styling with radial gradient
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.7,
            colors: [Color.fromARGB(38, 19, 236, 55), Color(0xFF102213)],
          ),
        ),
        child: Stack(
          children: [
            // Decorative background circle
            Positioned(
              top: -100,
              left: -100,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFF13ec37).withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(200),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Logo Container
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      color: const Color(0xFF102213).withValues(alpha: 0.5),
                      border: Border.all(
                        color: const Color(0xFF13ec37).withValues(alpha: 0.3),
                      ),
                      borderRadius: BorderRadius.circular(80),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Material(
                      color: Colors.transparent,
                      child: Icon(
                        Icons.self_improvement,
                        color: Color(0xFF13ec37),
                        size: 80,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // App Name
                  const Text(
                    'Yoga Mentor',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // App Tagline
                  const Text(
                    'Your AI-powered yoga guide',
                    style: TextStyle(color: Color(0xFF13ec37), fontSize: 16),
                  ),
                  const SizedBox(height: 60),

                  /// 🔥 Animated Progress Indicator section
                  Column(
                    children: [
                      Text(
                        'Initializing Practice... ${(_progress.value * 100).toInt()}%',
                        style: const TextStyle(color: Colors.white60),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 220,
                        child: LinearProgressIndicator(
                          value: _progress.value,
                          backgroundColor: const Color.fromARGB(
                            25,
                            19,
                            236,
                            55,
                          ),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF13ec37),
                          ),
                          minHeight: 6,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
