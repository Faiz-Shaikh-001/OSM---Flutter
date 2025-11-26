import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  // Keys for SharedPreferences
  static const String keyPushEnabled = 'notify_push_enabled';
  static const String keyLowStock = 'notify_low_stock';
  static const String keyNewOrder = 'notify_new_order';
  static const String keyDailySummary = 'notify_daily_summary';

  // Singleton pattern
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  // --- Permission Handling ---
  Future<bool> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  Future<bool> checkPermissionStatus() async {
    return await Permission.notification.isGranted;
  }

  // --- Settings Management ---

  Future<Map<String, bool>> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      keyPushEnabled: prefs.getBool(keyPushEnabled) ?? false,
      keyLowStock: prefs.getBool(keyLowStock) ?? true,
      keyNewOrder: prefs.getBool(keyNewOrder) ?? true,
      keyDailySummary: prefs.getBool(keyDailySummary) ?? false,
    };
  }

  Future<void> updateSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);

    // If enabling push notifications, ensure we have permission
    if (key == keyPushEnabled && value == true) {
      bool granted = await checkPermissionStatus();
      if (!granted) {
        await requestNotificationPermission();
      }
    }
  }

  // --- Logic Hooks (Use these in your other ViewModels/Repos) ---

  Future<bool> shouldNotifyLowStock() async {
    final prefs = await SharedPreferences.getInstance();
    final masterSwitch = prefs.getBool(keyPushEnabled) ?? false;
    final featureSwitch = prefs.getBool(keyLowStock) ?? true;
    return masterSwitch && featureSwitch;
  }

  Future<bool> shouldNotifyNewOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final masterSwitch = prefs.getBool(keyPushEnabled) ?? false;
    final featureSwitch = prefs.getBool(keyNewOrder) ?? true;
    return masterSwitch && featureSwitch;
  }

  // Example method to actually trigger a notification (stub)
  Future<void> triggerLocalNotification({required String title, required String body}) async {
    // 1. Check global switch
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(keyPushEnabled) != true) return;

    // 2. Real implementation would go here using flutter_local_notifications
    debugPrint('🔔 NOTIFICATION TRIGGERED: $title - $body');
  }
}