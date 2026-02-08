abstract class SettingsEvent {}

class LoadSettings extends SettingsEvent {}

class ToggleDarkMode extends SettingsEvent {
  final bool value;
  ToggleDarkMode(this.value);
}

class TogglePushNotifications extends SettingsEvent {
  final bool value;
  TogglePushNotifications(this.value);
}

class ToggleLowStockAlerts extends SettingsEvent {
  final bool value;
  ToggleLowStockAlerts(this.value);
}

class ToggleNewOrderNotifications extends SettingsEvent {
  final bool value;
  ToggleNewOrderNotifications(this.value);
}

class ToggleDailySummary extends SettingsEvent {
  final bool value;
  ToggleDailySummary(this.value);
}

class UpdateStockThreshold extends SettingsEvent {
  final int value;
  UpdateStockThreshold(this.value);
}

class UpdateDefaultTaxRate extends SettingsEvent {
  final double value;
  UpdateDefaultTaxRate(this.value);
}
class UpdateDiscountRate extends SettingsEvent {
  final double value;
  UpdateDiscountRate(this.value);
}
class UpdateInvoiceFooterMessage extends SettingsEvent {
  final String value;
  UpdateInvoiceFooterMessage(this.value);
}