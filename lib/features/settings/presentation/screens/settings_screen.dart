import 'package:flutter/material.dart';
// Note: To make the currency picker work, you would add this package:
// import 'package:currency_picker/currency_picker.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // --- State variables for the new UI ---
  bool _isDarkModeEnabled = false;
  bool _pushNotificationsEnabled = true;
  bool _lowStockAlertsEnabled = true;
  bool _newOrderNotificationsEnabled = true;
  bool _dailySummaryEnabled = false;

  @override
  Widget build(BuildContext context) {
    // Using Theme.of(context) to make colors adapt to light/dark mode
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
          // --- Store/Branch Selector ---
          ListTile(
            leading: Icon(Icons.storefront_outlined, color: theme.colorScheme.primary),
            title: const Text('Select Store/Branch', style: TextStyle(fontWeight: FontWeight.w500)),
            trailing: const Icon(Icons.swap_horiz),
            onTap: () {
              // TODO: Implement store/branch selection logic
              print('Select Store/Branch tapped');
            },
          ),
          const Divider(height: 20),

          // --- App Preferences Section ---
          _buildSectionTitle(Icons.settings_outlined, 'App Preferences', headingColor),
          _buildSwitchItem(
            Icons.brightness_6_outlined,
            'Enable Dark Mode',
            _isDarkModeEnabled,
            (value) => setState(() => _isDarkModeEnabled = value),
          ),
          _buildSettingsItem(
            Icons.currency_rupee_outlined,
            'Currency Preference (INR, USD, etc.)',
            onTap: () {
              // TODO: Show currency picker from the 'currency_picker' package
              print('Currency Preference tapped');
            },
          ),
          const Divider(height: 30),

          // --- Notifications Section ---
          _buildSectionTitle(Icons.notifications_outlined, 'Notifications', headingColor),
          _buildSwitchItem(
            Icons.notifications_active_outlined,
            'Enable Push Notifications',
            _pushNotificationsEnabled,
            (value) => setState(() => _pushNotificationsEnabled = value),
          ),
          _buildSwitchItem(
            Icons.warning_amber_rounded,
            'Low Stock Alerts',
            _lowStockAlertsEnabled,
            (value) => setState(() => _lowStockAlertsEnabled = value),
          ),
          _buildSwitchItem(
            Icons.inventory_2_outlined,
            'New Order Notifications',
            _newOrderNotificationsEnabled,
            (value) => setState(() => _newOrderNotificationsEnabled = value),
          ),
          _buildSwitchItem(
            Icons.today_outlined,
            'Daily Summary Notification',
            _dailySummaryEnabled,
            (value) => setState(() => _dailySummaryEnabled = value),
          ),
          const Divider(height: 30),

          // --- Inventory Settings Section ---
          _buildSectionTitle(Icons.inventory_2_outlined, 'Inventory Settings', headingColor),
          _buildSettingsItem(Icons.production_quantity_limits_outlined, 'Default Stock Warning Threshold'),
          _buildSettingsItem(Icons.edit_note_outlined, 'Set Invoice Footer Message'),
          _buildSettingsItem(Icons.price_change_outlined, 'Default Tax Rate (GST %)'),
          _buildSettingsItem(Icons.percent_outlined, 'Default Discount Rate'),
          const Divider(height: 30),
          
          // --- Security & Support Section ---
          _buildSectionTitle(Icons.security_outlined, 'Security & Support', headingColor),
          _buildSettingsItem(Icons.cloud_sync_outlined, 'Backup & Restore'),
          _buildSettingsItem(Icons.phonelink_lock_outlined, 'Enable App Lock (PIN/Biometric)'),
          _buildSettingsItem(Icons.people_outline, 'Manage Staff Access'),
          const Divider(height: 30),
          
          // --- Account Navigation Item ---
          ListTile(
            leading: Text('👤', style: TextStyle(fontSize: 24)),
            title: Text('Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: Navigate to a new Account page
              print('Navigate to Account Page');
            },
          ),
          const Divider(height: 30),

          // --- Help & Support Section ---
          _buildSectionTitle(Icons.help_outline, 'Help & Support', headingColor),
          _buildSettingsItem(Icons.quiz_outlined, 'FAQs'),
          _buildSettingsItem(Icons.support_agent_outlined, 'Contact Support'),
          _buildSettingsItem(Icons.menu_book_outlined, 'User Manual'),
          const Divider(height: 30),

          // --- About Section ---
          _buildSectionTitle(Icons.info_outline, 'About', headingColor),
          _buildSettingsItem(Icons.info_outline, 'App Version'),
          _buildSettingsItem(Icons.description_outlined, 'Terms & Conditions'),
          _buildSettingsItem(Icons.privacy_tip_outlined, 'Privacy Policy'),
          _buildSettingsItem(Icons.code_outlined, 'Licenses'),
        ],
      ),
    );
  }

  // Helper for section titles with an icon
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

  // Helper for standard navigation items
  Widget _buildSettingsItem(IconData icon, String title, {VoidCallback? onTap, bool isDestructive = false}) {
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
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap ?? () => print('$title tapped'), // Use provided onTap or default print
    );
  }

  // Helper for toggle/switch items
  Widget _buildSwitchItem(IconData icon, String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      secondary: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: Theme.of(context).colorScheme.primary,
    );
  }
}