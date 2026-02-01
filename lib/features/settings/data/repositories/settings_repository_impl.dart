import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../models/app_settings_model.dart';
import '../sources/settings_local_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalSource localSource;

  SettingsRepositoryImpl(this.localSource);

  @override
  Future<AppSettings> getSettings() async {
    final model = await localSource.loadSettings();

    return AppSettings(
      darkMode: model.darkMode,
      pushNotifications: model.pushNotifications,
      lowStockAlerts: model.lowStockAlerts,
      newOrderNotifications: model.newOrderNotifications,
      dailySummary: model.dailySummary,
    );
  }

  @override
  Future<void> saveSettings(AppSettings settings) async {
    final model = AppSettingsModel(
      darkMode: settings.darkMode,
      pushNotifications: settings.pushNotifications,
      lowStockAlerts: settings.lowStockAlerts,
      newOrderNotifications: settings.newOrderNotifications,
      dailySummary: settings.dailySummary,
    );

    await localSource.saveSettings(model);
  }
}
