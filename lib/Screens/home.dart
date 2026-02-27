import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_mentore/Providers/user_provider.dart';
import 'dart:io';
import 'userprofile.dart';

/// The main landing screen after login, displaying challenges and recommendations
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Reactive state for progress
  double _progress = 0.0;

  // Data for daily yoga challenges
  final List<Map<String, dynamic>> dailyPoses = const [
    {
      "title": "Tree Pose",
      "desc": "Balance & focus",
      "image": "assets/images/pexels-photo-3823039.jpeg",
    },
    {
      "title": "Warrior I",
      "desc": "Strength pose",
      "image": "assets/images/pexels-photo-317157.jpeg",
    },
    {
      "title": "Downward Dog",
      "desc": "Full body stretch",
      "image": "assets/images/pexels-photo-3822622.jpeg",
    },
    {
      "title": "Cobra Pose",
      "desc": "Spine flexibility",
      "image": "assets/images/pexels-photo-4056723.jpeg",
    },
    {
      "title": "Mountain Pose",
      "desc": "Posture alignment",
      "image": "assets/images/pexels-photo-8436587.jpeg",
    },
    {
      "title": "Child Pose",
      "desc": "Relax & breathe",
      "image": "assets/images/pexels-photo-3757376.jpeg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final theme = Theme.of(context);
    final isDark = userProvider.isDarkMode;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _topBar(userProvider, theme),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 80),
                child: Column(
                  children: [
                    _dailyChallengeSlider(theme, isDark),
                    _continuePractice(theme, isDark),
                    _weeklyActivity(theme, isDark),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- TOP BAR ----------------
  Widget _topBar(UserProvider userProvider, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const YogaProfilePage(),
                ),
              );
            },
            borderRadius: BorderRadius.circular(30),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage:
                      userProvider.profileImage.startsWith('assets/')
                      ? AssetImage(userProvider.profileImage) as ImageProvider
                      : FileImage(File(userProvider.profileImage)),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "WELCOME",
                      style: TextStyle(
                        color: theme.colorScheme.primary.withValues(alpha: 0.7),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      userProvider.name,
                      style: TextStyle(
                        color: theme.textTheme.bodyLarge?.color,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("No new notifications")),
              );
            },
            icon: CircleAvatar(
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              child: Icon(
                Icons.notifications_outlined,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- DAILY CHALLENGE ----------------
  Widget _dailyChallengeSlider(ThemeData theme, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            "Daily Challenge",
            style: TextStyle(
              color: theme.textTheme.titleLarge?.color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: dailyPoses.length,
            itemBuilder: (context, index) {
              final pose = dailyPoses[index];
              return InkWell(
                onTap: () {
                  setState(() {
                    _progress = (_progress + 0.1).clamp(0.0, 1.0);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Started ${pose["title"]}")),
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 220,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF19331E) : Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          image: DecorationImage(
                            image: AssetImage(pose["image"]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pose["title"],
                              style: TextStyle(
                                color: theme.textTheme.bodyLarge?.color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              pose["desc"],
                              style: TextStyle(
                                color: theme.textTheme.bodySmall?.color,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ---------------- CONTINUE PRACTICE ----------------
  Widget _continuePractice(ThemeData theme, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF19331E) : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Continue Practice",
              style: TextStyle(
                color: theme.textTheme.titleLarge?.color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "You have completed ${(_progress * 100).toInt()}% of today’s challenge",
              style: TextStyle(
                color: theme.textTheme.bodyMedium?.color?.withValues(
                  alpha: 0.7,
                ),
              ),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: _progress,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
              minHeight: 6,
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- WEEKLY ACTIVITY ----------------
  Widget _weeklyActivity(ThemeData theme, bool isDark) {
    const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF19331E) : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Weekly Activity",
              style: TextStyle(
                color: theme.textTheme.titleLarge?.color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: days
                  .map(
                    (d) => Tooltip(
                      message: "Activity for $d",
                      child: InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Details for $d coming soon!"),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 12,
                              height: 40,
                              decoration: BoxDecoration(
                                color: theme.primaryColor.withValues(
                                  alpha: 0.25,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              d,
                              style: TextStyle(
                                color: theme.textTheme.bodySmall?.color,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
