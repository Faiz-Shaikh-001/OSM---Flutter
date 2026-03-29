import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_settings_model.dart';

class SettingsLocalSource {
  static const _darkModeKey = 'darkMode';
  static const _pushNotificationsKey = 'pushNotifications';
  static const _lowStockAlertsKey = 'lowStockAlerts';
  static const _newOrderNotificationsKey = 'newOrderNotifications';
  static const _dailySummaryKey = 'dailySummary';

  Future<AppSettingsModel> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    return AppSettingsModel(
      darkMode: prefs.getBool(_darkModeKey) ?? false,
      pushNotifications: prefs.getBool(_pushNotificationsKey) ?? true,
      lowStockAlerts: prefs.getBool(_lowStockAlertsKey) ?? true,
      newOrderNotifications:
          prefs.getBool(_newOrderNotificationsKey) ?? true,
      dailySummary: prefs.getBool(_dailySummaryKey) ?? false,
    );
  }

  Future<void> saveSettings(AppSettingsModel model) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_darkModeKey, model.darkMode);
    await prefs.setBool(_pushNotificationsKey, model.pushNotifications);
    await prefs.setBool(_lowStockAlertsKey, model.lowStockAlerts);
    await prefs.setBool(
        _newOrderNotificationsKey, model.newOrderNotifications);
    await prefs.setBool(_dailySummaryKey, model.dailySummary);
  }
}
