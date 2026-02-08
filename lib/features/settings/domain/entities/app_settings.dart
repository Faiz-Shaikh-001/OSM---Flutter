class AppSettings {
  final bool darkMode;
  final bool pushNotifications;
  final bool lowStockAlerts;
  final bool newOrderNotifications;
  final bool dailySummary;

  const AppSettings({
    required this.darkMode,
    required this.pushNotifications,
    required this.lowStockAlerts,
    required this.newOrderNotifications,
    required this.dailySummary,
  });

  /// Default settings when app runs for the first time
  factory AppSettings.initial() {
    return const AppSettings(
      darkMode: false,
      pushNotifications: true,
      lowStockAlerts: true,
      newOrderNotifications: true,
      dailySummary: false,
    );
  }
  bool get allowNotifications =>
      pushNotifications ||
      lowStockAlerts ||
      newOrderNotifications ||
      dailySummary;

  /// Creates a new copy with updated values
  AppSettings copyWith({
    bool? darkMode,
    bool? pushNotifications,
    bool? lowStockAlerts,
    bool? newOrderNotifications,
    bool? dailySummary,
  }) {
    return AppSettings(
      darkMode: darkMode ?? this.darkMode,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      lowStockAlerts: lowStockAlerts ?? this.lowStockAlerts,
      newOrderNotifications:
          newOrderNotifications ?? this.newOrderNotifications,
      dailySummary: dailySummary ?? this.dailySummary,
    );
  }
}
