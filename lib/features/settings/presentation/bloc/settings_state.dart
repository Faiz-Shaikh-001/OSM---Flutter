import '../../domain/entities/app_settings.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final AppSettings settings;

  SettingsLoaded(this.settings);
}
