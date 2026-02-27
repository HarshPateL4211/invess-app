import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        title: const Text("Settings"),
        elevation: 2,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 🔵 Profile Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.blue.shade900,
                    child: const Text(
                      "I",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    "9033229677",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 🔹 General Section
            _buildSectionCard(
              title: "General",
              children: [
                _buildTile(Icons.check_circle_outline, "Applied IPO"),
                _buildTile(Icons.person_add_alt_outlined, "Add Pan Number"),
                _buildTile(Icons.notifications_none, "Notifications"),
                _buildTile(Icons.settings_outlined, "Notification Settings"),
                _buildTile(Icons.article_outlined, "News"),
              ],
            ),

            const SizedBox(height: 20),

            /// 🔹 Help & Support Section
            _buildSectionCard(
              title: "Help & Support",
              children: [
                _buildTile(Icons.support_agent, "Support"),
                _buildTile(Icons.info_outline, "About Us"),
                _buildTile(Icons.description_outlined, "Terms Condition"),
                _buildTile(Icons.privacy_tip_outlined, "Privacy Policy"),
                _buildTile(Icons.help_outline, "FAQs"),
              ],
            ),

            const SizedBox(height: 30),

            /// 🔴 Logout Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  // Logout logic here
                },
                icon: const Icon(Icons.logout),
                label: const Text("Log Out"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Section Card
  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(height: 1),
          ...children,
        ],
      ),
    );
  }

  /// 🔹 List Tile
  Widget _buildTile(IconData icon, String title) {
    return ListTile(
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.blue.withOpacity(0.1),
        child: Icon(icon, size: 18, color: Colors.blue),
      ),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // Navigate or handle action
      },
    );
  }
}
