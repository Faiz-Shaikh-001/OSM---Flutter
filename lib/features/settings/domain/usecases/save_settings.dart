import '../entities/app_settings.dart';
import '../repositories/settings_repository.dart';

class SaveSettings {
  final SettingsRepository repository;

  SaveSettings(this.repository);

  Future<void> call(AppSettings settings) {
    return repository.saveSettings(settings);
  }
}
