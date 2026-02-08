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
    on<TogglePushNotifications>(_onTogglePushNotifications);
    on<ToggleLowStockAlerts>(_onToggleLowStockAlerts);
    on<ToggleNewOrderNotifications>(_onToggleNewOrderNotifications);
    on<ToggleDailySummary>(_onToggleDailySummary);
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

  /// 🔥 MASTER SWITCH (FIXED)
  Future<void> _onTogglePushNotifications(
    TogglePushNotifications event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is! SettingsLoaded) return;

    final current = (state as SettingsLoaded).settings;

    final updated = event.value
        ? current.copyWith(
            pushNotifications: true,
            lowStockAlerts: true,
            newOrderNotifications: true,
            dailySummary: true,
          )
        : current.copyWith(
            pushNotifications: false,
            lowStockAlerts: false,
            newOrderNotifications: false,
            dailySummary: false,
          );

    await updateSettings(updated);
    emit(SettingsLoaded(updated));
  }

  Future<void> _onToggleLowStockAlerts(
    ToggleLowStockAlerts event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is! SettingsLoaded) return;

    final current = (state as SettingsLoaded).settings;
    final updated = current.copyWith(lowStockAlerts: event.value);

    await updateSettings(updated);
    emit(SettingsLoaded(updated));
  }

  Future<void> _onToggleNewOrderNotifications(
    ToggleNewOrderNotifications event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is! SettingsLoaded) return;

    final current = (state as SettingsLoaded).settings;
    final updated = current.copyWith(newOrderNotifications: event.value);

    await updateSettings(updated);
    emit(SettingsLoaded(updated));
  }

  Future<void> _onToggleDailySummary(
    ToggleDailySummary event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is! SettingsLoaded) return;

    final current = (state as SettingsLoaded).settings;
    final updated = current.copyWith(dailySummary: event.value);

    await updateSettings(updated);
    emit(SettingsLoaded(updated));
  }
}