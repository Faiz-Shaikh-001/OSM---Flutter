import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_settings.dart';
import '../../domain/usecases/save_settings.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettings getSettings;
  final SaveSettings saveSettings;

  SettingsBloc({
    required this.getSettings,
    required this.saveSettings,
  }) : super(SettingsState.initial()) {

    /// Load settings when screen opens
    on<LoadSettings>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final settings = await getSettings();

      emit(
        state.copyWith(
          settings: settings,
          isLoading: false,
        ),
      );
    });

    /// Save updated settings
    on<UpdateSettings>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      await saveSettings(event.settings);

      emit(
        state.copyWith(
          settings: event.settings,
          isLoading: false,
        ),
      );
    });
  }
}
