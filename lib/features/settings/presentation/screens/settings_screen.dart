import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// --- IMPORTS ---
import 'package:osm/core/services/isar_service.dart'; 
import 'package:osm/core/theme_provider.dart'; 
import 'package:osm/features/orders/data/models/store_model.dart';

// Relative screen imports
import 'select_store_screen.dart';
import 'accounts_screen.dart'; 
import 'inventory_settings_screen.dart'; 
import 'notification_settings_screen.dart'; // New import

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final IsarService isarService = IsarService();
  String _selectedStoreName = 'No Store Selected';
  int? _selectedStoreId;

  @override
  void initState() {
    super.initState();
    _loadSelectedStore();
  }

  Future<void> _loadSelectedStore() async {
    final prefs = await SharedPreferences.getInstance();
    final storeId = prefs.getInt(selectedStoreIdKey);

    if (storeId != null) {
      final isar = await isarService.db;
      final store = await isar.stores.get(storeId);
      if (store != null && mounted) {
        setState(() {
          _selectedStoreName = store.name;
          _selectedStoreId = store.id;
        });
      }
    } else if (mounted) {
       setState(() {
        _selectedStoreName = 'Select a Store';
        _selectedStoreId = null;
      });
    }
  }

  void _navigateAndSelectStore() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SelectStoreScreen(),
      ),
    );
    
    if (result != null) {
      _loadSelectedStore();
    }
  }

  void _openInventorySettings() {
    if (_selectedStoreId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a store first.')),
      );
      return;
    }
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InventorySettingsScreen(storeId: _selectedStoreId!),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);
    final headingColor = theme.textTheme.titleLarge?.color?.withOpacity(0.8);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings & Preferences'),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: [
          ListTile(
            leading: Icon(Icons.storefront_outlined, color: theme.colorScheme.primary),
            title: Text(_selectedStoreName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            trailing: const Icon(Icons.swap_horiz),
            onTap: _navigateAndSelectStore,
          ),
          const Divider(height: 20),
          
          _buildSectionTitle(Icons.settings_outlined, 'App Preferences', headingColor),
          
          SwitchListTile(
            secondary: Icon(Icons.brightness_6_outlined, color: theme.colorScheme.primary),
            title: const Text('Enable Dark Mode', style: TextStyle(fontWeight: FontWeight.w500)),
            value: themeProvider.themeMode == ThemeMode.dark, 
            activeColor: theme.colorScheme.primary,
            onChanged: (bool value) {
              themeProvider.setTheme(value);
            },
          ),

          _buildSettingsItem(
            Icons.currency_rupee_outlined,
            'Currency Preference (INR, USD, etc.)',
            onTap: () {
              print('Currency Preference tapped');
            },
          ),
          const Divider(height: 30),

          _buildSectionTitle(Icons.notifications_outlined, 'Notifications', headingColor),
          // --- UPDATED: Single entry point for Notifications ---
          _buildSettingsItem(
            Icons.notifications_active_outlined,
            'Manage Notifications',
            subtitle: 'Push alerts, Stock warnings, Daily summaries',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const NotificationSettingsScreen()),
              );
            },
          ),
          const Divider(height: 30),
          
          _buildSectionTitle(Icons.inventory_2_outlined, 'Inventory Settings', headingColor),
          
          _buildSettingsItem(
            Icons.tune, 
            'General Configuration',
            subtitle: 'Stock Threshold, Tax Rate, Footer Message',
            onTap: _openInventorySettings,
          ),
          const Divider(height: 30),
          
          _buildSectionTitle(Icons.security_outlined, 'Security & Support', headingColor),
          _buildSettingsItem(Icons.cloud_sync_outlined, 'Backup & Restore'),
          _buildSettingsItem(Icons.phonelink_lock_outlined, 'Enable App Lock (PIN/Biometric)'),
          _buildSettingsItem(Icons.people_outline, 'Manage Staff Access'),
          const Divider(height: 30),
          
          ListTile(
            leading: const Text('👤', style: TextStyle(fontSize: 24)),
            title: const Text('Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AccountScreen()));
            },
          ),
          const Divider(height: 30),

          _buildSectionTitle(Icons.help_outline, 'Help & Support', headingColor),
          _buildSettingsItem(Icons.quiz_outlined, 'FAQs'),
          _buildSettingsItem(Icons.support_agent_outlined, 'Contact Support'),
          _buildSettingsItem(Icons.menu_book_outlined, 'User Manual'),
          const Divider(height: 30),

          _buildSectionTitle(Icons.info_outline, 'About', headingColor),
          _buildSettingsItem(Icons.info_outline, 'App Version'),
          _buildSettingsItem(Icons.description_outlined, 'Terms & Conditions'),
          _buildSettingsItem(Icons.privacy_tip_outlined, 'Privacy Policy'),
          _buildSettingsItem(Icons.code_outlined, 'Licenses'),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(IconData icon, String title, Color? color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    IconData icon, 
    String title, {
    VoidCallback? onTap, 
    bool isDestructive = false,
    String? subtitle,
  }) {
    final theme = Theme.of(context);
    final color = isDestructive ? Colors.red : theme.colorScheme.primary;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : null,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null ? Text(subtitle, style: TextStyle(color: Colors.grey[600])) : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap ?? () => print('$title tapped'),
    );
  }
}