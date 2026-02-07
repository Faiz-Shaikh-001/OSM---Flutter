abstract class SettingsFailure {
  final String message;
  const SettingsFailure(this.message);
}

class SettingsLoadFailure extends SettingsFailure {
  const SettingsLoadFailure(super.message);
}

class SettingsSaveFailure extends SettingsFailure {
  const SettingsSaveFailure(super.message);
}
