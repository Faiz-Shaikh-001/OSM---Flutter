import 'package:flutter/material.dart';
import 'package:osm/core/services/notification_service.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  final NotificationService _service = NotificationService();
  
  // State variables
  bool _pushEnabled = false;
  bool _lowStock = true;
  bool _newOrder = true;
  bool _dailySummary = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final settings = await _service.loadSettings();
    if (mounted) {
      setState(() {
        _pushEnabled = settings[NotificationService.keyPushEnabled]!;
        _lowStock = settings[NotificationService.keyLowStock]!;
        _newOrder = settings[NotificationService.keyNewOrder]!;
        _dailySummary = settings[NotificationService.keyDailySummary]!;
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleSetting(String key, bool value) async {
    // Optimistic UI update
    setState(() {
      if (key == NotificationService.keyPushEnabled) _pushEnabled = value;
      if (key == NotificationService.keyLowStock) _lowStock = value;
      if (key == NotificationService.keyNewOrder) _newOrder = value;
      if (key == NotificationService.keyDailySummary) _dailySummary = value;
    });

    // Persist logic & Permissions check
    await _service.updateSetting(key, value);
    
    // Reload to ensure permission state consistency (e.g., if user denied permission)
    if (key == NotificationService.keyPushEnabled && value == true) {
       bool hasPerm = await _service.checkPermissionStatus();
       if (!hasPerm && mounted) {
         // Revert if permission denied
         setState(() => _pushEnabled = false);
         ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text('Notification permission is required to enable this feature.')),
         );
       }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // --- Master Switch ---
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.colorScheme.primary.withOpacity(0.3)),
            ),
            child: SwitchListTile(
              secondary: Icon(Icons.notifications_active, color: theme.colorScheme.primary),
              title: const Text(
                'Allow Notifications',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Master switch for all alerts'),
              value: _pushEnabled,
              activeColor: theme.colorScheme.primary,
              onChanged: (val) => _toggleSetting(NotificationService.keyPushEnabled, val),
            ),
          ),
          
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Alert Types', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          ),
          const SizedBox(height: 8),

          // --- Specific Toggles (Disabled if Master is OFF) ---
          Opacity(
            opacity: _pushEnabled ? 1.0 : 0.5,
            child: Column(
              children: [
                _buildToggleItem(
                  context,
                  Icons.warning_amber_rounded,
                  'Low Stock Alerts',
                  'Get notified when items reach minimum quantity',
                  _lowStock,
                  NotificationService.keyLowStock,
                ),
                const Divider(),
                _buildToggleItem(
                  context,
                  Icons.inventory_2_outlined,
                  'New Order Notifications',
                  'Instant alerts for incoming orders',
                  _newOrder,
                  NotificationService.keyNewOrder,
                ),
                const Divider(),
                _buildToggleItem(
                  context,
                  Icons.today_outlined,
                  'Daily Summary',
                  'Receive sales report at 11:59 PM', // Updated time
                  _dailySummary,
                  NotificationService.keyDailySummary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    bool value,
    String key,
  ) {
    final theme = Theme.of(context);
    return SwitchListTile(
      secondary: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: theme.colorScheme.onSurfaceVariant),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      value: value,
      activeColor: theme.colorScheme.primary,
      // Disable interaction if master switch is off
      onChanged: _pushEnabled ? (val) => _toggleSetting(key, val) : null,
    );
  }
}