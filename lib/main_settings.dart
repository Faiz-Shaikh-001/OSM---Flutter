import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/settings/settings_di.dart';
import 'features/settings/presentation/screens/settings_screen.dart';

class SettingsBootstrap extends StatelessWidget {
  const SettingsBootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ...settingsBlocProviders(),
      ],
      child: const SettingsScreen(),
    );
  }
}
