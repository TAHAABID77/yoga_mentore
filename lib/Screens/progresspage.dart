import 'package:flutter/material.dart';

/// Screen displaying user's yoga practice progress and statistics
class YogaProgressPage extends StatelessWidget {
  const YogaProgressPage({super.key});

  // Theme constants
  static const Color primaryGreen = Color(0xFF13EC37);
  static const Color backgroundDark = Color(0xFF102213);
  static const Color surfaceDark = Color(0xFF1C2E1D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Weekly activity visualization
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildWeeklyChartCard(),
              ),
            ),

            // Key performance indicators grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.4,
                ),
                delegate: SliverChildListDelegate([
                  _buildStatCard(
                    Icons.schedule_outlined,
                    'Total Time',
                    '12h 45m',
                    '+2h',
                  ),
                  _buildStatCard(
                    Icons.analytics_outlined,
                    'Avg. Accuracy',
                    '88%',
                    '+3%',
                  ),
                ]),
              ),
            ),

            // Health metrics overview
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildStreakCard(),
              ),
            ),

            // Session history header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent History',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to full history placeholder
                      },
                      child: const Text(
                        'View All',
                        style: TextStyle(color: primaryGreen),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // List of recent practice sessions
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildHistoryItem('Sun Salutation A', 'Oct 24, 2023 • 25 mins', '92%'),
                  _buildHistoryItem('Warrior II Flow', 'Oct 22, 2023 • 40 mins', '85%'),
                  _buildHistoryItem('Hatha Morning Bliss', 'Oct 21, 2023 • 15 mins', '78%'),
                  _buildHistoryItem('Balance & Strength', 'Oct 19, 2023 • 30 mins', '90%'),
                  const SizedBox(height: 120), // Bottom padding for navigation clearance
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Card displaying weekly session activity chart
  Widget _buildWeeklyChartCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'WEEKLY ACTIVITY',
            style: TextStyle(
              color: primaryGreen.withValues(alpha: 0.7),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '12 Sessions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Row(
            children: [
              Icon(Icons.trending_up, color: primaryGreen, size: 16),
              SizedBox(width: 4),
              Text(
                '+15% ',
                style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold),
              ),
              Text(
                'Oct 18 - Oct 24',
                style: TextStyle(color: Colors.white38, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar(0.3, 'MON'),
                _buildBar(0.9, 'TUE', isFull: true),
                _buildBar(0.65, 'WED'),
                _buildBar(0.8, 'THU', isFull: true),
                _buildBar(0.25, 'FRI'),
                _buildBar(0.55, 'SAT'),
                _buildBar(0.75, 'SUN', isFull: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Individual bar component for the activity chart
  Widget _buildBar(double heightFactor, String day, {bool isFull = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 32,
          height: 100 * heightFactor,
          decoration: BoxDecoration(
            color: isFull ? primaryGreen : primaryGreen.withValues(alpha: 0.2),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /// Generic stat card for various metrics
  Widget _buildStatCard(IconData icon, String label, String value, String change) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: primaryGreen),
              Text(
                change,
                style: const TextStyle(color: primaryGreen, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: const TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold),
              ),
              Text(
                value,
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Card highlighting calorie and streak information
  Widget _buildStreakCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.local_fire_department, color: Colors.orange),
                  const SizedBox(width: 8),
                  Text(
                    'CALORIES BURNED'.toUpperCase(),
                    style: const TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Text(
                'Daily Streak: 4',
                style: TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '1,240 kcal',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  /// Individual history record item component
  Widget _buildHistoryItem(String title, String subtitle, String accuracy) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: primaryGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.check_circle_outline, color: primaryGreen),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white38, fontSize: 11),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                accuracy,
                style: const TextStyle(color: primaryGreen, fontWeight: FontWeight.bold),
              ),
              const Text(
                'ACCURACY',
                style: TextStyle(color: Colors.white38, fontSize: 9, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
