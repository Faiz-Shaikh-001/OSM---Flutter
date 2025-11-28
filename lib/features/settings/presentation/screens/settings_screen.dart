import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Ensure url_launcher is imported since we used it in the previous step
import 'package:url_launcher/url_launcher.dart';

import 'package:osm/core/services/isar_service.dart'; 
import 'package:osm/core/theme_provider.dart'; 
import 'package:osm/features/orders/data/models/store_model.dart';

import 'select_store_screen.dart';
import 'accounts_screen.dart'; 
import 'inventory_settings_screen.dart'; 
import 'notification_settings_screen.dart';
import 'legal_text_screen.dart'; 
import 'faq_screen.dart';
import 'backup_restore_screen.dart'; // New import

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

  void _showLegalScreen(String title, String content) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LegalTextScreen(title: title, content: content),
      ),
    );
  }

  void _showContactSupportDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Support',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.email, color: Colors.white),
              ),
              title: const Text('Email Us'),
              subtitle: const Text('support@opticsstore.com'),
              onTap: () async {
                Navigator.pop(context);
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'support@opticsstore.com',
                  query: 'subject=Support Request&body=Hi, I need help with...',
                );
                if (await canLaunchUrl(emailLaunchUri)) {
                  await launchUrl(emailLaunchUri);
                }
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.phone, color: Colors.white),
              ),
              title: const Text('Call Us'),
              subtitle: const Text('+1 800 123 4567'),
              onTap: () async {
                Navigator.pop(context);
                final Uri phoneLaunchUri = Uri(
                  scheme: 'tel',
                  path: '+18001234567',
                );
                if (await canLaunchUrl(phoneLaunchUri)) {
                  await launchUrl(phoneLaunchUri);
                }
              },
            ),
          ],
        ),
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

          // --- UPDATED: Fixed Currency Preference ---
          _buildSettingsItem(
            Icons.currency_rupee_outlined,
            'Currency Preference',
            subtitle: 'INR (₹)', // Hardcoded to INR
          ),
          const Divider(height: 30),

          _buildSectionTitle(Icons.notifications_outlined, 'Notifications', headingColor),
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
          // --- UPDATED: Backup & Restore Navigation ---
          _buildSettingsItem(
            Icons.cloud_sync_outlined, 
            'Backup & Restore',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const BackupRestoreScreen()),
              );
            },
          ),
          
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
          _buildSettingsItem(
            Icons.quiz_outlined, 
            'FAQs',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const FAQScreen()),
              );
            },
          ),
          _buildSettingsItem(
            Icons.support_agent_outlined, 
            'Contact Support',
            onTap: _showContactSupportDialog,
          ),

          const Divider(height: 30),

          _buildSectionTitle(Icons.info_outline, 'About', headingColor),
          _buildSettingsItem(
            Icons.info_outline, 
            'App Version',
            subtitle: 'v1.0.0', 
            onTap: () {}, 
          ),
          _buildSettingsItem(
            Icons.description_outlined, 
            'Terms & Conditions',
            onTap: () => _showLegalScreen('Terms & Conditions', 'Here are the terms and conditions...\n\n1. Use responsibly.\n2. Data is stored locally.\n3. ...'),
          ),
          _buildSettingsItem(
            Icons.privacy_tip_outlined, 
            'Privacy Policy',
            onTap: () => _showLegalScreen('Privacy Policy', 'Your privacy is important to us...\n\nWe do not share your data with third parties.'),
          ),
          _buildSettingsItem(
            Icons.code_outlined, 
            'Licenses',
            onTap: () => showLicensePage(
              context: context,
              applicationName: 'Optics Store Management',
              applicationVersion: 'v1.0.0',
              applicationIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.inventory_2, size: 48),
              ),
            ),
          ),
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
      trailing: (onTap != null && subtitle != 'v1.0.0') ? const Icon(Icons.arrow_forward_ios, size: 16) : null,
      onTap: onTap,
    );
  }
}