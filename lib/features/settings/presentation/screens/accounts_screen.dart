import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Internal imports
import 'manage_stores_screen.dart';
import 'select_store_screen.dart';

// Path to IsarService and Dashboard
import '../../../../../core/services/isar_service.dart';
//import '../../../../../core/features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../../dashboard/presentation/screens/dashboard_screen.dart';
// Feature imports
import '../../staff/presentation/screens/manage_staff_screen.dart';
import '../../profile/models/screens/edit_profile_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  // --- Helper Methods for UI ---

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

  // --- Action Logic ---

  Future<void> _confirmSignOut(BuildContext context) async {
    final shouldSignOut = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out? This will clear your current session preferences.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );

    if (shouldSignOut == true) {
      final prefs = await SharedPreferences.getInstance();
      // Clear session data like selected store
      await prefs.remove(selectedStoreIdKey);
      
      if (context.mounted) {
        // Navigate back to the Dashboard (acting as the initial screen) 
        // and remove all previous routes to simulate a fresh start.
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
          (route) => false,
        );
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed out successfully.')),
        );
      }
    }
  }

  Future<void> _confirmDeleteAccount(BuildContext context) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to permanently delete your account? \n\nWARNING: This will wipe ALL data, including customers, orders, inventory, stores, and staff. This action cannot be undone.',
          style: TextStyle(color: Colors.red),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('DELETE EVERYTHING'),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      // 1. Clear Database
      final isarService = IsarService();
      await isarService.cleanDb();

      // 2. Clear Preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      if (context.mounted) {
        // 3. Navigate to home/dashboard to restart
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
          (route) => false,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account and all data deleted.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
          
          const Divider(height: 40),

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

          _buildSectionTitle('Account Actions', context),
          _buildListTile(
            Icons.logout,
            'Sign Out',
            onTap: () => _confirmSignOut(context),
          ),
          _buildDestructiveTile(
            Icons.delete_forever_outlined,
            'Delete Account',
            onTap: () => _confirmDeleteAccount(context),
          ),
        ],
      ),
    );
  }
}