class AppSettings {
  final bool darkMode;
  final bool pushNotifications;
  final bool lowStockAlerts;
  final bool newOrderNotifications;
  final bool dailySummary;

  // Inventory
  final int stockWarningThreshold;
  final double defaultTaxRate;
  final double discountRate;
  final String invoiceFooterMessage;

  const AppSettings({
    required this.darkMode,
    required this.pushNotifications,
    required this.lowStockAlerts,
    required this.newOrderNotifications,
    required this.dailySummary,
    required this.stockWarningThreshold,
    required this.defaultTaxRate,
    required this.discountRate,
    required this.invoiceFooterMessage,
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
      discountRate: 0.0,
      invoiceFooterMessage: 'Thank you',
    );
  }

  /// Master notification switch (derived)
  bool get allowNotifications =>
      pushNotifications ||
      lowStockAlerts ||
      newOrderNotifications ||
      dailySummary;

  /// UX helpers (SAFE & OPTIONAL)
  String get stockThresholdLabel =>
      'Alert when quantity is less than $stockWarningThreshold';

  String get taxRateLabel =>
      'Current: ${defaultTaxRate.toStringAsFixed(1)}%';

  String get discountRateLabel =>
      'Current: ${discountRate.toStringAsFixed(1)}%';

  String get footerMessageLabel =>
      invoiceFooterMessage.isEmpty ? 'Not set' : invoiceFooterMessage;

  /// Creates a new copy with updated values
  AppSettings copyWith({
    bool? darkMode,
    bool? pushNotifications,
    bool? lowStockAlerts,
    bool? newOrderNotifications,
    bool? dailySummary,
    int? stockWarningThreshold,
    double? defaultTaxRate,
    double? discountRate,
    String? invoiceFooterMessage,
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
      discountRate: discountRate ?? this.discountRate,
      invoiceFooterMessage: invoiceFooterMessage ?? this.invoiceFooterMessage,
    );
  }
}
