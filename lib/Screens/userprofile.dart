import 'package:flutter/material.dart';

/// User profile screen displaying stats, settings, and personal details
class YogaProfilePage extends StatelessWidget {
  final String userName;
  const YogaProfilePage({super.key, this.userName = "Ahmed Khan"});

  // Theme colors for consistent branding
  static const Color primaryGreen = Color(0xFF13EC37);
  static const Color backgroundDark = Color(0xFF102213);
  static const Color surfaceDark = Color(0xFF1A2E1D);
  static const Color cardDark = Color(0xFF1E3A24);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header section
          const SliverAppBar(
            expandedHeight: 0,
            floating: true,
            backgroundColor: backgroundDark,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text(
              'MY PROFILE',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            centerTitle: true,
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // --- Profile Image with Glow Effect ---
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryGreen.withValues(alpha: 0.5), width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: primaryGreen.withValues(alpha: 0.15),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                      ),
                      const CircleAvatar(
                        radius: 62,
                        backgroundColor: surfaceDark,
                        backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: primaryGreen, shape: BoxShape.circle),
                          child: const Icon(Icons.camera_alt, size: 18, color: backgroundDark),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Name and user status
                  Text(
                    userName,
                    style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Level 3 • Yoga Practitioner',
                    style: TextStyle(color: primaryGreen.withValues(alpha: 0.8), fontSize: 14, fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(height: 30),

                  // --- Key Statistics Row ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatItem("24", "Sessions"),
                      _buildStatItem("1.2k", "Minutes"),
                      _buildStatItem("12", "Day Streak"),
                    ],
                  ),

                  const SizedBox(height: 35),

                  // --- Account Settings Section ---
                  _buildSectionLabel("ACCOUNT"),
                  _buildModernTile(
                    icon: Icons.person_outline_rounded,
                    title: "Edit Personal Details",
                    onTap: () {},
                  ),
                  _buildModernTile(
                    icon: Icons.history_rounded,
                    title: "Practice History",
                    onTap: () {},
                  ),
                  _buildModernTile(
                    icon: Icons.favorite_border_rounded,
                    title: "My Favorite Poses",
                    onTap: () {},
                    trailing: const Text("12", style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold)),
                  ),

                  const SizedBox(height: 25),

                  // --- App Preferences Section ---
                  _buildSectionLabel("PREFERENCES"),
                  _buildModernTile(
                    icon: Icons.notifications_none_rounded,
                    title: "Notification Settings",
                    onTap: () {},
                  ),
                  _buildModernTile(
                    icon: Icons.verified_user_outlined,
                    title: "Privacy & Security",
                    onTap: () {},
                  ),
                  _buildModernTile(
                    icon: Icons.support_agent_rounded,
                    title: "Help & Support",
                    onTap: () {},
                  ),

                  const SizedBox(height: 50),

                  // --- Centered Logout Action ---
                  Center(
                    child: InkWell(
                      onTap: () {
                        // Logout logic placeholder
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.redAccent.withValues(alpha: 0.5)),
                          color: Colors.redAccent.withValues(alpha: 0.1),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.power_settings_new_rounded, color: Colors.redAccent, size: 20),
                            SizedBox(width: 10),
                            Text(
                              "Logout",
                              style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper: Individual statistic item card
  Widget _buildStatItem(String value, String label) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: cardDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(color: primaryGreen, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12),
          ),
        ],
      ),
    );
  }

  /// Helper: Descriptive section label
  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  /// Helper: Styled list tile for settings items
  Widget _buildModernTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: surfaceDark.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: backgroundDark,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: primaryGreen, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
        ),
        trailing: trailing ?? Icon(Icons.arrow_forward_ios_rounded, color: Colors.white.withValues(alpha: 0.2), size: 16),
      ),
    );
  }
}
