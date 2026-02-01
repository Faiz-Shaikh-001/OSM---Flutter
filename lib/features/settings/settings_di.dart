import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/sources/settings_local_source.dart';
import 'data/repositories/settings_repository_impl.dart';
import 'domain/usecases/get_settings.dart';
import 'domain/usecases/update_settings.dart';
import 'presentation/bloc/settings_bloc.dart';

List<BlocProvider> settingsBlocProviders() {
  // Data layer
  final localSource = SettingsLocalSource();
  final repository = SettingsRepositoryImpl(localSource);

  // Domain layer
  final getSettings = GetSettings(repository);
  final updateSettings = UpdateSettings(repository);

  // Presentation layer
  return [
    BlocProvider<SettingsBloc>(
      create: (_) => SettingsBloc(
        getSettings: getSettings,
        updateSettings: updateSettings,
      ),
    ),
  ];
}
