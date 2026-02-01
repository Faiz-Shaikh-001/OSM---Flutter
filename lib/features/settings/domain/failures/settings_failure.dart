abstract class SettingsFailure {
  final String message;
  const SettingsFailure(this.message);
}

class SettingsLoadFailure extends SettingsFailure {
  const SettingsLoadFailure(String message) : super(message);
}

class SettingsSaveFailure extends SettingsFailure {
  const SettingsSaveFailure(String message) : super(message);
}
