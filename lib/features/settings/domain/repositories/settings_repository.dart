import '../entities/app_settings.dart';

abstract class SettingsRepository {
  /// Load settings from storage
  Future<AppSettings> getSettings();

  /// Save updated settings
  Future<void> saveSettings(AppSettings settings);
}
