import 'package:flutter/material.dart';

/// Screen displaying a searchable library of yoga poses
class PoseLibraryPage extends StatefulWidget {
  const PoseLibraryPage({super.key});

  @override
  State<PoseLibraryPage> createState() => _PoseLibraryPageState();
}

class _PoseLibraryPageState extends State<PoseLibraryPage> {
  // Premium Yoga Theme Colors for consistent branding
  static const Color primaryGreen = Color(0xFF13EC37);
  static const Color backgroundDark = Color(0xFF0C1B0E);
  static const Color surfaceDark = Color(0xFF162A19);
  static const Color accentGreen = Color(0xFF92C99B);

  // Controllers for scrolling
  final ScrollController _scrollController = ScrollController();

  // Keys for each category section
  final GlobalKey _beginnerKey = GlobalKey();
  final GlobalKey _intermediateKey = GlobalKey();
  final GlobalKey _advancedKey = GlobalKey();

  // Data from home.dart
  final List<Map<String, dynamic>> poses = const [
    {
      "title": "Mountain Pose",
      "sub": "Tadasana",
      "time": "5 min",
      "level": "Beginner",
      "color": Colors.greenAccent,
      "image": "assets/images/pexels-photo-8436587.jpeg",
    },
    {
      "title": "Child Pose",
      "sub": "Balasana",
      "time": "3 min",
      "level": "Beginner",
      "color": Colors.greenAccent,
      "image": "assets/images/pexels-photo-3757376.jpeg",
    },
    {
      "title": "Tree Pose",
      "sub": "Vrikshasana",
      "time": "5 min",
      "level": "Beginner",
      "color": Colors.greenAccent,
      "image": "assets/images/pexels-photo-3823039.jpeg",
    },
    {
      "title": "Warrior I",
      "sub": "Virabhadrasana I",
      "time": "6 min",
      "level": "Intermediate",
      "color": Colors.orangeAccent,
      "image": "assets/images/pexels-photo-317157.jpeg",
    },
    {
      "title": "Downward Dog",
      "sub": "Adho Mukha Svanasana",
      "time": "8 min",
      "level": "Intermediate",
      "color": Colors.orangeAccent,
      "image": "assets/images/pexels-photo-3822622.jpeg",
    },
    {
      "title": "Cobra Pose",
      "sub": "Bhujangasana",
      "time": "7 min",
      "level": "Advanced",
      "color": Colors.redAccent,
      "image": "assets/images/pexels-photo-4056723.jpeg",
    },
  ];

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Sticky header with search and categories
            SliverAppBar(
              backgroundColor: backgroundDark,
              floating: true,
              pinned: true,
              elevation: 0,
              automaticallyImplyLeading: false,
              expandedHeight: 180,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'POSE LIBRARY',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Find the perfect pose for your practice today.',
                        style: TextStyle(color: accentGreen, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(100),
                child: Container(
                  color: backgroundDark,
                  child: Column(
                    children: [
                      _buildSearchBar(),
                      _buildCategoryChips(),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
            // Beginner Section
            SliverToBoxAdapter(
              key: _beginnerKey,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Text(
                  'BEGINNER',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            _buildGridSection('Beginner'),

            // Intermediate Section
            SliverToBoxAdapter(
              key: _intermediateKey,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Text(
                  'INTERMEDIATE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            _buildGridSection('Intermediate'),

            // Advanced Section
            SliverToBoxAdapter(
              key: _advancedKey,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Text(
                  'ADVANCED / EXPERT',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            _buildGridSection('Advanced'),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildGridSection(String level) {
    final filteredPoses = poses.where((p) => p['level'] == level).toList();

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final pose = filteredPoses[index];
          return _buildPoseCard(
            context,
            pose['title'],
            pose['sub'],
            pose['time'],
            pose['level'],
            pose['color'],
            pose['image'],
          );
        }, childCount: filteredPoses.length),
      ),
    );
  }

  /// Search bar component with custom styling
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: primaryGreen.withValues(alpha: 0.05),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search poses...',
            hintStyle: TextStyle(color: accentGreen.withValues(alpha: 0.5)),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: primaryGreen,
              size: 22,
            ),
            filled: true,
            fillColor: surfaceDark,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  /// Horizontal list of category filter chips
  Widget _buildCategoryChips() {
    final categories = ['All', 'Beginner', 'Intermediate', 'Advanced'];
    return SizedBox(
      height: 55,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isActive = index == 0;
          return GestureDetector(
            onTap: () {
              if (categories[index] == 'Beginner') {
                _scrollToSection(_beginnerKey);
              } else if (categories[index] == 'Intermediate') {
                _scrollToSection(_intermediateKey);
              } else if (categories[index] == 'Advanced') {
                _scrollToSection(_advancedKey);
              } else if (categories[index] == 'All') {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 22),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isActive ? primaryGreen : surfaceDark,
                borderRadius: BorderRadius.circular(12),
                border: isActive
                    ? null
                    : Border.all(color: Colors.white.withValues(alpha: 0.05)),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  color: isActive ? backgroundDark : Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Reusable quick filter button component
  Widget _buildQuickFilter(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: surfaceDark.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryGreen, size: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.grey,
            size: 16,
          ),
        ],
      ),
    );
  }

  /// Individual yoga pose card component
  Widget _buildPoseCard(
    BuildContext context,
    String title,
    String sub,
    String time,
    String level,
    Color levelColor,
    String image,
  ) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Selected $title")));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: surfaceDark,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Difficulty Level Badge
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: backgroundDark.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: levelColor.withValues(alpha: 0.5),
                          width: 0.5,
                        ),
                      ),
                      child: Text(
                        level,
                        style: TextStyle(
                          color: levelColor,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              const Icon(Icons.access_time, color: accentGreen, size: 12),
              const SizedBox(width: 4),
              Text(
                '$sub • $time',
                style: const TextStyle(color: accentGreen, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
