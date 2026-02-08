import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/features/settings/settings_di.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';
import '../widgets/settings_section_title.dart';
import '../widgets/settings_tile.dart';
import '../widgets/settings_switch_tile.dart';
import '../widgets/store_selector_tile.dart';
import 'package:osm/core/theme_provider.dart';
import 'notification_section/notification_settings_screen.dart';
import 'inventory_section/inventory_settings_screen.dart';
import 'about_section/about_screen.dart';

/// ─────────────────────────────────────────────────────────────
/// Entry point for Settings feature (DI boundary)
/// ─────────────────────────────────────────────────────────────
class SettingsEntry extends StatelessWidget {
  const SettingsEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...settingsBlocProviders()],
      child: const SettingsScreen(),
    );
  }
}

/// ─────────────────────────────────────────────────────────────
/// Settings Screen (UI only)
/// ─────────────────────────────────────────────────────────────
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings & Preferences'), elevation: 1),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is! SettingsLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final settings = state.settings;
          final themeProvider = context.read<ThemeProvider>();

          // Sync theme only if needed
          final isDark = settings.darkMode;
          final currentThemeIsDark = themeProvider.themeMode == ThemeMode.dark;

          if (isDark != currentThemeIsDark) {
            themeProvider.setTheme(isDark);
          }

          return ListView(
            children: [
              // ───────────────────────── Store Selector ─────────────────────────
              const StoreSelectorTile(storeName: 'No Store Selected'),
              const Divider(height: 24),

              // ─────────────────────── App Preferences ───────────────────────
              const SettingsSectionTitle(
                icon: Icons.settings_outlined,
                title: 'App Preferences',
              ),
              SettingsSwitchTile(
                icon: Icons.brightness_6_outlined,
                title: 'Enable Dark Mode',
                value: settings.darkMode,
                onChanged: (value) {
                  // 1️⃣ Update settings (persisted)
                  context.read<SettingsBloc>().add(ToggleDarkMode(value));

                  // 2️⃣ Update theme immediately
                  context.read<ThemeProvider>().setTheme(value);
                },
              ),

              const SettingsTile(
                icon: Icons.currency_rupee_outlined,
                title: 'Currency Preference',
                subtitle: 'INR (₹)',
              ),
              const Divider(height: 32),

              // ─────────────────────── Notifications ───────────────────────
              const SettingsSectionTitle(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
              ),
              SettingsTile(
                icon: Icons.notifications_active_outlined,
                title: 'Manage Notifications',
                subtitle: 'Push alerts, Stock warnings, Daily summaries',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<SettingsBloc>(),
                        child: const NotificationSettingsScreen(),
                      ),
                    ),
                  );
                },
              ),
              const Divider(height: 32),

              // ─────────────────────── Inventory Settings ───────────────────────
              const SettingsSectionTitle(
                icon: Icons.inventory_2_outlined,
                title: 'Inventory Settings',
              ),
              SettingsTile(
                icon: Icons.tune_outlined,
                title: 'General Configuration',
                subtitle: 'Stock Threshold, Tax Rate, Footer Message',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<SettingsBloc>(),
                        child: const InventorySettingsScreen(),
                      ),
                    ),
                  );
                },
              ),

              const Divider(height: 32),

              // ─────────────────────── Security & Support ───────────────────────
              const SettingsSectionTitle(
                icon: Icons.security_outlined,
                title: 'Security & Support',
              ),
              const SettingsTile(
                icon: Icons.cloud_sync_outlined,
                title: 'Backup & Restore',
              ),
              const Divider(height: 32),

              // ─────────────────────── Account ───────────────────────
              const SettingsSectionTitle(
                icon: Icons.person_outline,
                title: 'Account',
              ),
              const SettingsTile(icon: Icons.person_outline, title: 'Account'),
              const Divider(height: 32),

              // ─────────────────────── Help & Support ───────────────────────
              const SettingsSectionTitle(
                icon: Icons.help_outline,
                title: 'Help & Support',
              ),
              const SettingsTile(icon: Icons.quiz_outlined, title: 'FAQs'),
              const SettingsTile(
                icon: Icons.support_agent_outlined,
                title: 'Contact Support',
              ),
              const Divider(height: 32),

              // ─────────────────────── About ───────────────────────
              SettingsTile(
                icon: Icons.info_outline,
                title: 'About',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AboutScreen()),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
