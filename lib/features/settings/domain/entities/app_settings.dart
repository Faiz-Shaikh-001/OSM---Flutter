class AppSettings {
  final bool darkMode;
  final bool pushNotifications;
  final bool lowStockAlerts;
  final bool newOrderNotifications;
  final bool dailySummary;
  final int stockWarningThreshold;
  final double defaultTaxRate;

  const AppSettings({
    required this.darkMode,
    required this.pushNotifications,
    required this.lowStockAlerts,
    required this.newOrderNotifications,
    required this.dailySummary,
    required this.stockWarningThreshold,
    required this.defaultTaxRate,

  });

  /// Default settings when app runs for the first time
  factory AppSettings.initial() {
    return const AppSettings(
      darkMode: false,
      pushNotifications: true,
      lowStockAlerts: true,
      newOrderNotifications: true,
      dailySummary: false,
      stockWarningThreshold: 5,
      defaultTaxRate: 0.0,
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
    int? stockWarningThreshold,
    double? defaultTaxRate,
  }) {
    return AppSettings(
      darkMode: darkMode ?? this.darkMode,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      lowStockAlerts: lowStockAlerts ?? this.lowStockAlerts,
      newOrderNotifications:
          newOrderNotifications ?? this.newOrderNotifications,
      dailySummary: dailySummary ?? this.dailySummary,
      stockWarningThreshold:
          stockWarningThreshold ?? this.stockWarningThreshold,
      defaultTaxRate: defaultTaxRate ?? this.defaultTaxRate,
    );
  }
}
