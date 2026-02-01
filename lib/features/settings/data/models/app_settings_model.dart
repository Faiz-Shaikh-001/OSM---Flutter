class AppSettingsModel {
  final bool darkMode;
  final bool pushNotifications;
  final bool lowStockAlerts;
  final bool newOrderNotifications;
  final bool dailySummary;

  const AppSettingsModel({
    required this.darkMode,
    required this.pushNotifications,
    required this.lowStockAlerts,
    required this.newOrderNotifications,
    required this.dailySummary,
  });

  factory AppSettingsModel.fromMap(Map<String, dynamic> map) {
    return AppSettingsModel(
      darkMode: map['darkMode'] as bool,
      pushNotifications: map['pushNotifications'] as bool,
      lowStockAlerts: map['lowStockAlerts'] as bool,
      newOrderNotifications: map['newOrderNotifications'] as bool,
      dailySummary: map['dailySummary'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'darkMode': darkMode,
      'pushNotifications': pushNotifications,
      'lowStockAlerts': lowStockAlerts,
      'newOrderNotifications': newOrderNotifications,
      'dailySummary': dailySummary,
    };
  }
}
