import '../../domain/entities/app_settings.dart';

abstract class SettingsEvent {}

/// When settings screen opens
class LoadSettings extends SettingsEvent {}

/// When user updates any setting
class UpdateSettings extends SettingsEvent {
  final AppSettings settings;

  UpdateSettings(this.settings);
}
