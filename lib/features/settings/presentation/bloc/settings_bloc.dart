import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_settings.dart';
import '../../domain/usecases/update_settings.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettings getSettings;
  final UpdateSettings updateSettings;

  SettingsBloc({
    required this.getSettings,
    required this.updateSettings,
  }) : super(SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<ToggleDarkMode>(_onToggleDarkMode);
  }

  Future<void> _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    final settings = await getSettings();
    emit(SettingsLoaded(settings));
  }

  Future<void> _onToggleDarkMode(
    ToggleDarkMode event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is! SettingsLoaded) return;

    final current = (state as SettingsLoaded).settings;
    final updated = current.copyWith(darkMode: event.value);

    await updateSettings(updated);
    emit(SettingsLoaded(updated));
  }
}
