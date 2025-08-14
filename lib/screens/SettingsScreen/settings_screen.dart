import 'package:flutter/material.dart';
// Note: To make the currency picker work, you would add this package:
// import 'package:currency_picker/currency_picker.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // --- State variables for interactive elements ---
  bool _lowStockAlertsEnabled = true;
  bool _autoTriggerScanner = false;
  bool _dailySalesReportEnabled = true;
  bool _printInvoiceAutomatically = false;
  bool _pushNotificationsEnabled = true;
  bool _newOrderNotifications = true;
  bool _dailySummaryEnabled = false;
  
  String _themeMode = 'System Default';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        children: [
          // --- Account Section ---
          _buildSectionTitle('👤 Account'),
          _buildSettingsItem(Icons.store_outlined, 'View/Edit Profile'),
          _buildSettingsItem(Icons.alternate_email_outlined, 'Change Email / Phone Number'),
          _buildSettingsItem(Icons.logout, 'Sign Out', isDestructive: true),
          const Divider(height: 30),

          // --- App Preferences Section ---
          _buildSectionTitle('⚙️ App Preferences'),
          _buildThemeModeDropdown(),
          _buildSettingsItem(Icons.currency_rupee_outlined, 'Currency Preference'),
          const Divider(height: 30),

          // --- Inventory Settings Section ---
          _buildSectionTitle('📦 Inventory Settings'),
          _buildSettingsItem(Icons.warning_amber_rounded, 'Default Stock Warning Threshold'),
          _buildSwitchItem(
            Icons.notifications_active_outlined, 
            'Enable Low Stock Alerts', 
            _lowStockAlertsEnabled, 
            (value) => setState(() => _lowStockAlertsEnabled = value)
          ),
          _buildSettingsItem(Icons.price_change_outlined, 'Default Tax Rate ( GST %)'),
          _buildSwitchItem(
            Icons.qr_code_scanner_outlined, 
            'Auto-trigger Barcode Scanner', 
            _autoTriggerScanner, 
            (value) => setState(() => _autoTriggerScanner = value)
          ),
          const Divider(height: 30),

          // --- Sales Settings Section ---
          _buildSectionTitle('📊 Sales Settings'),
          _buildSwitchItem(
            Icons.summarize_outlined, 
            'Enable Daily Sales Report', 
            _dailySalesReportEnabled, 
            (value) => setState(() => _dailySalesReportEnabled = value)
          ),
          _buildSettingsItem(Icons.percent_outlined, 'Default Discount Rate'),
          _buildSwitchItem(
            Icons.print_outlined, 
            'Print Invoice Automatically', 
            _printInvoiceAutomatically, 
            (value) => setState(() => _printInvoiceAutomatically = value)
          ),
          _buildSettingsItem(Icons.edit_note_outlined, 'Set Invoice Footer Message'),
          const Divider(height: 30),

          // --- Notifications Section ---
          _buildSectionTitle('🔔 Notifications'),
          _buildSwitchItem(
            Icons.notifications_outlined, 
            'Enable Push Notifications', 
            _pushNotificationsEnabled, 
            (value) => setState(() => _pushNotificationsEnabled = value)
          ),
          _buildSwitchItem(
            Icons.inventory_2_outlined, 
            'New Order Notifications', 
            _newOrderNotifications, 
            (value) => setState(() => _newOrderNotifications = value)
          ),
          _buildSwitchItem(
            Icons.today_outlined, 
            'Daily Summary Notification', 
            _dailySummaryEnabled, 
            (value) => setState(() => _dailySummaryEnabled = value)
          ),
          const Divider(height: 30),

          // --- Security & Privacy Section ---
          _buildSectionTitle('🔐 Security & Privacy'),
          _buildSettingsItem(Icons.phonelink_lock_outlined, 'Enable App Lock (PIN/Biometric)'),
          _buildSettingsItem(Icons.people_outline, 'Manage Staff Access'),
          _buildSettingsItem(Icons.security_outlined, 'Backup & Restore'),
          const Divider(height: 30),

          // --- Utilities Section ---
          _buildSectionTitle('🧰 Utilities'),
          _buildSettingsItem(Icons.cloud_upload_outlined, 'Data Backup'),
          _buildSettingsItem(Icons.cloud_download_outlined, 'Data Restore'),
          _buildSettingsItem(Icons.delete_sweep_outlined, 'Clear Cache'),
          const Divider(height: 30),
          
          // --- Help & Support Section ---
          _buildSectionTitle('❓ Help & Support'),
          _buildSettingsItem(Icons.quiz_outlined, 'FAQs'),
          _buildSettingsItem(Icons.support_agent_outlined, 'Contact Support'),
          _buildSettingsItem(Icons.menu_book_outlined, 'User Manual'),
          const Divider(height: 30),

          // --- About Section ---
          _buildSectionTitle('📄 About'),
          _buildSettingsItem(Icons.info_outline, 'App Version'),
          _buildSettingsItem(Icons.description_outlined, 'Terms & Conditions'),
          _buildSettingsItem(Icons.privacy_tip_outlined, 'Privacy Policy'),
          _buildSettingsItem(Icons.code_outlined, 'Licenses'),
          _buildSettingsItem(Icons.developer_mode_outlined, 'Developer Info'),
        ],
      ),
    );
  }

  // Helper for standard navigation items
  Widget _buildSettingsItem(
    IconData icon,
    String title, {
    bool isDestructive = false,
  }) {
    final color = isDestructive ? Colors.red : Theme.of(context).colorScheme.primary;
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
      onTap: () {
        // Placeholder for navigation or action
        print('$title tapped');
      },
    );
  }

  // Helper for toggle/switch items
  Widget _buildSwitchItem(
    IconData icon,
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
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

  // Specific helper for the Theme Mode dropdown
  Widget _buildThemeModeDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.brightness_6_outlined, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 16),
              const Text(
                'Theme Mode',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ],
          ),
          DropdownButton<String>(
            value: _themeMode,
            underline: const SizedBox(), // Removes the underline
            items: ['Light', 'Dark', 'System Default'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _themeMode = newValue;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  // Helper for section titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}
