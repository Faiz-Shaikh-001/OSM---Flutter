import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  static const _darkModeKey = 'dark_mode';
  static const _pushNotificationsKey = 'push_notifications';
  static const _lowStockAlertsKey = 'low_stock_alerts';
  static const _newOrderNotificationsKey = 'new_order_notifications';
  static const _dailySummaryKey = 'daily_summary';

  @override
  Future<AppSettings> getSettings() async {
    final prefs = await SharedPreferences.getInstance();

    return AppSettings(
      darkMode: prefs.getBool(_darkModeKey) ?? false,
      pushNotifications: prefs.getBool(_pushNotificationsKey) ?? true,
      lowStockAlerts: prefs.getBool(_lowStockAlertsKey) ?? true,
      newOrderNotifications:
          prefs.getBool(_newOrderNotificationsKey) ?? true,
      dailySummary: prefs.getBool(_dailySummaryKey) ?? false,
    );
  }

  @override
  Future<void> saveSettings(AppSettings settings) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_darkModeKey, settings.darkMode);
    await prefs.setBool(
        _pushNotificationsKey, settings.pushNotifications);
    await prefs.setBool(
        _lowStockAlertsKey, settings.lowStockAlerts);
    await prefs.setBool(
        _newOrderNotificationsKey, settings.newOrderNotifications);
    await prefs.setBool(
        _dailySummaryKey, settings.dailySummary);
  }
}
