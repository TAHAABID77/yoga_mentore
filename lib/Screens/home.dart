import 'package:flutter/material.dart';

/// The main landing screen after login, displaying challenges and recommendations
class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({super.key, this.userName = "Yogi"});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Theme constants for consistent styling
  static const Color primary = Color(0xFF13EC37);
  static const Color bgDark = Color(0xFF102213);
  static const Color cardDark = Color(0xFF19331E);
  static const Color textMuted = Color(0xFF92C99B);

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
    return Scaffold(
      backgroundColor: bgDark,
      body: SafeArea(
        child: Column(
          children: [
            _topBar(), // User profile and notifications
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 80),
                child: Column(
                  children: [
                    _dailyChallengeSlider(), // Horizontal challenge slider
                    _continuePractice(), // Current progress tracker
                    _weeklyActivity(), // Activity visualization
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
  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              // Action for profile
            },
            borderRadius: BorderRadius.circular(30),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(
                    "https://i.pravatar.cc/150?img=12",
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "WELCOME",
                      style: TextStyle(
                        color: textMuted,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.userName,
                      style: const TextStyle(
                        color: Colors.white,
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
            icon: const CircleAvatar(
              backgroundColor: cardDark,
              child: Icon(Icons.notifications_outlined, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- DAILY CHALLENGE ----------------
  Widget _dailyChallengeSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            "Daily Challenge",
            style: TextStyle(
              color: Colors.white,
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
                    color: cardDark,
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
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              pose["desc"],
                              style: const TextStyle(
                                color: textMuted,
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
  Widget _continuePractice() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardDark,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Continue Practice",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "You have completed ${(_progress * 100).toInt()}% of today’s challenge",
              style: const TextStyle(color: textMuted),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.white10,
              valueColor: const AlwaysStoppedAnimation<Color>(primary),
              minHeight: 6,
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- WEEKLY ACTIVITY ----------------
  Widget _weeklyActivity() {
    const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardDark,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Weekly Activity",
              style: TextStyle(
                color: Colors.white,
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
                            SnackBar(content: Text("Details for $d coming soon!")),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 12,
                              height: 40,
                              decoration: BoxDecoration(
                                color: primary.withValues(alpha: 0.25),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              d,
                              style: const TextStyle(
                                color: textMuted,
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
