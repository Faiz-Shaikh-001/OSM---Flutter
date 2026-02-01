import '../entities/app_settings.dart';
import '../repositories/settings_repository.dart';

class UpdateSettings {
  final SettingsRepository repository;

  UpdateSettings(this.repository);

  Future<void> call(AppSettings settings) {
    return repository.saveSettings(settings);
  }
}
