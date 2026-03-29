import 'package:flutter_bloc/flutter_bloc.dart';

// ───────── DATA ─────────
import 'data/repositories/settings_repository_impl.dart';
import 'data/repositories/account_repository_impl.dart';

// ───────── DOMAIN ─────────
import 'domain/usecases/get_settings.dart';
import 'domain/usecases/update_settings.dart';
import 'domain/usecases/get_account.dart';
import 'domain/usecases/update_account.dart';

// ───────── PRESENTATION ─────────
import 'presentation/bloc/settings_bloc.dart';
import 'presentation/bloc/settings_event.dart';
import 'presentation/bloc/account_bloc.dart';
import 'data/sources/account_local_source.dart';


List<BlocProvider> settingsBlocProviders() {
  // ───────── Settings Data ─────────
  final settingsRepository = SettingsRepositoryImpl();
  final getSettings = GetSettings(settingsRepository);
  final updateSettings = UpdateSettings(settingsRepository);

  // ───────── Account Data ─────────
  final accountLocalSource = AccountLocalSource();
  final accountRepository = AccountRepositoryImpl(accountLocalSource);
  final getAccount = GetAccount(accountRepository);
  final updateAccount = UpdateAccount(accountRepository);

  return [
    BlocProvider<SettingsBloc>(
      create: (_) => SettingsBloc(
        getSettings: getSettings,
        updateSettings: updateSettings,
      )..add(LoadSettings()),
    ),

    BlocProvider<AccountBloc>(
      create: (_) => AccountBloc(
        getAccount: getAccount,
        updateAccount: updateAccount,
      )..add(LoadAccount()),
    ),
  ];
}
