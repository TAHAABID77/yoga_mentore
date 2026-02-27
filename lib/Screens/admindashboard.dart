import 'package:flutter/material.dart';

void main() {
  runApp(YogaAdminApp());
}

class YogaAdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF102213),
      appBar: AppBar(
        backgroundColor: Color(0xFF102213),
        title: Text("Admin Dashboard"),
        centerTitle: true,
        leading: Icon(Icons.account_circle),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {},
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Real-time Overview",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            SizedBox(height: 15),

            Row(
              children: [
                Expanded(child: statCard("Total Users", "12.5k", Icons.group)),
                SizedBox(width: 10),
                Expanded(child: statCard("Active", "432", Icons.circle)),
              ],
            ),

            SizedBox(height: 10),

            statCard("Pose Database", "154 Verified", Icons.accessibility_new),

            SizedBox(height: 25),

            Text("Management Menu",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            SizedBox(height: 15),

            menuItem(Icons.self_improvement, "Manage Poses",
                "Edit AI coordinates and descriptions"),

            menuItem(Icons.forum, "User Feedback",
                "Review unread reports and ratings"),

            menuItem(Icons.system_update_alt, "System Updates",
                "AI Engine v2.4.1 - Status: Optimal"),

            menuItem(Icons.settings, "Global Config",
                "API endpoints and notification triggers"),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1a2e1d),
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: "Overview"),
          BottomNavigationBarItem(
              icon: Icon(Icons.manage_accounts), label: "Users"),
          BottomNavigationBarItem(
              icon: Icon(Icons.storage), label: "Library"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Alerts"),
          BottomNavigationBarItem(
              icon: Icon(Icons.tune), label: "Settings"),
        ],
      ),
    );
  }

  Widget statCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF1a2e1d),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
              Icon(icon, color: Colors.greenAccent)
            ],
          ),
          SizedBox(height: 10),
          Text(value,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget menuItem(IconData icon, String title, String subtitle) {
    return Card(
      color: Color(0xFF1a2e1d),
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.greenAccent),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}
