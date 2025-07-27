import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text('John Doe'),
            subtitle: Text('john.doe@example.com'),
            trailing: Icon(Icons.edit, color: Colors.grey),
          ),
          const Divider(height: 30),

          _buildSectionTitle('Account'),
          _buildSettingsItem(Icons.lock_outline, 'Change Password'),
          _buildSettingsItem(Icons.notifications_none, 'Notifications'),
          _buildSettingsItem(Icons.language, 'Language'),
          _buildSettingsItem(Icons.dark_mode, 'Dark Mode'),

          const Divider(height: 30),

          _buildSectionTitle('Help & Support'),
          _buildSettingsItem(Icons.info_outline, 'About'),
          _buildSettingsItem(Icons.help_outline, 'Help Center'),
          _buildSettingsItem(Icons.privacy_tip_outlined, 'Privacy Policy'),
          _buildSettingsItem(Icons.logout, 'Logout', isDestructive: true),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    IconData icon,
    String title, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : Colors.blueAccent,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // Implement functionality here
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}
