import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/account_bloc.dart';
import 'profile_screen.dart';
import '../../widgets/settings_section_title.dart';
import '../../widgets/settings_tile.dart';
import 'package:osm/features/store/presentation/bloc/store_location_bloc.dart';
import 'manage_stores_screen.dart';

import 'package:osm/features/staff/presentation/screens/manage_staff_screen.dart';
import 'package:osm/features/staff/presentation/bloc/staff_bloc.dart';
import 'package:osm/features/staff/presentation/bloc/staff_event.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: ListView(
        children: [
          // ─────────────────── User Profile ───────────────────
          const SettingsSectionTitle(
            icon: Icons.person_outline,
            title: 'User Profile',
          ),
          SettingsTile(
            icon: Icons.edit_outlined,
            title: 'View / Edit Profile',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<AccountBloc>(),
                    child: const ProfileScreen(),
                  ),
                ),
              );
            },
          ),

          const Divider(height: 32),

          // ───────────── Store & Staff Management ─────────────
          const SettingsSectionTitle(
            icon: Icons.store_outlined,
            title: 'Store & Staff Management',
          ),
          SettingsTile(
            icon: Icons.store_outlined,
            title: 'Manage Stores',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<StoreLocationBloc>(),
                    child: const ManageStoresScreen(),
                  ),
                ),
              );
            },
          ),
          SettingsTile(
            icon: Icons.people_outline,
            title: 'Manage Staff',
            onTap: () {
              final storeState = context.read<StoreLocationBloc>().state;

              if (storeState is StoreLocationLoaded &&
                  storeState.activeStore != null) {
                context.read<StaffBloc>().add(
                  LoadStaff(storeId: storeState.activeStore!.id!),
                );
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<StaffBloc>(),
                    child: const ManageStaffScreen(),
                  ),
                ),
              );
            },
          ),

          const Divider(height: 32),

          // ───────────────── Account Actions ─────────────────
          
          const SettingsSectionTitle(
            icon: Icons.security_outlined,
            title: 'Account Actions',
          ),
          SettingsTile(
            icon: Icons.logout,
            title: 'Sign Out',
            onTap: () => _confirmSignOut(context),
          ),
          SettingsTile(
            icon: Icons.delete_forever,
            title: 'Delete Account',
            onTap: () => _confirmDelete(context),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // ───────────────── Helpers ─────────────────

  static void _showComingSoon(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Coming Soon'),
        content: const Text(
          'This feature will be available in a future update.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void _confirmSignOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: real sign-out logic later
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  static void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to permanently delete your account? \n \n WARNING:This action will wipe ALL data including customers, orders, inventory, stores and staff. This action is permanent and cannot be undone',
        ),
        contentTextStyle: Colors.red[700] != null
            ? TextStyle(color: Colors.red)
            : const TextStyle(color: Colors.red),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              // TODO: delete account logic later
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
