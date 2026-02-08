abstract class SettingsEvent {}

class LoadSettings extends SettingsEvent {}

class ToggleDarkMode extends SettingsEvent {
  final bool value;
  ToggleDarkMode(this.value);
}
