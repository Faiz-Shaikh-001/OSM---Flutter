import '../../domain/entities/app_settings.dart';

class SettingsState {
  final AppSettings settings;
  final bool isLoading;

  const SettingsState({
    required this.settings,
    required this.isLoading,
  });

  factory SettingsState.initial() {
    return SettingsState(
      settings: AppSettings.initial(),
      isLoading: true,
    );
  }

  SettingsState copyWith({
    AppSettings? settings,
    bool? isLoading,
  }) {
    return SettingsState(
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}