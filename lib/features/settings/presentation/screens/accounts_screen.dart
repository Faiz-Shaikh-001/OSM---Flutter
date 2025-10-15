import 'package:flutter/material.dart';
import 'manage_stores_screen.dart';
import 'package:osm/features/settings/staff/presentation/screens/manage_staff_screen.dart';
import 'package:osm/features/settings/profile/models/screens/edit_profile_screen.dart';
// --- NEW: IMPORT THE CHANGE CREDENTIALS SCREEN ---
import 'package:osm/features/settings/staff/presentation/screens/change_credentials_screen.dart';


class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
      onTap: onTap ?? () {},
    );
  }

  Widget _buildDestructiveTile(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.red),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap ?? () {},
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        elevation: 1,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          // --- User Profile Section ---
          _buildSectionTitle('User Profile', context),
          _buildListTile(
            Icons.edit_outlined,
            'View/Edit Profile',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const EditProfileScreen()),
              );
            },
          ),
          // --- REDUNDANT OPTIONS REMOVED ---
          const Divider(height: 40),

          // --- Store & Staff Management Section ---
          _buildSectionTitle('Store & Staff Management', context),
          _buildListTile(
            Icons.store_mall_directory_outlined,
            'Manage Stores',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ManageStoresScreen()),
              );
            },
          ),
          _buildListTile(
            Icons.people_outline,
            'Manage Staff',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ManageStaffScreen()),
              );
            },
          ),
          const Divider(height: 40),

          // --- Account Actions Section ---
          _buildSectionTitle('Account Actions', context),
          _buildListTile(
            Icons.logout,
            'Sign Out',
            onTap: () {
              // TODO: Implement Sign Out logic
            },
          ),
          _buildDestructiveTile(
            Icons.delete_forever_outlined,
            'Delete Account',
            onTap: () {
              // TODO: Implement Delete Account logic with confirmation
            },
          ),
        ],
      ),
    );
  }
}

