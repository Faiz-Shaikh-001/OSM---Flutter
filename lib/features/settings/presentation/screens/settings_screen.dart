import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:osm/features/settings/settings_di.dart';
import 'package:osm/core/theme_provider.dart';

import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';
import '../bloc/account_bloc.dart';

import '../widgets/settings_section_title.dart';
import '../widgets/settings_tile.dart';
import '../widgets/settings_switch_tile.dart';
import '../widgets/store_selector_tile.dart';

import 'notification_section/notification_settings_screen.dart';
import 'inventory_section/inventory_settings_screen.dart';
import 'about_section/about_screen.dart';
import 'help_support_section/help_support_screen.dart';
import 'security_section/backup_restore_screen.dart';
import 'account_section/account_screen.dart';

import 'package:osm/features/store/presentation/bloc/store_location_bloc.dart';

/// ───────────────── Entry Point ─────────────────
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

/// ───────────────── Settings Screen ─────────────────
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings & Preferences')),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is! SettingsLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final settings = state.settings;
          final themeProvider = context.read<ThemeProvider>();

          if (settings.darkMode &&
              themeProvider.themeMode != ThemeMode.dark) {
            themeProvider.setTheme(true);
          }

          return ListView(
            children: [
              /// ───────── Store Selector ─────────
              BlocBuilder<StoreLocationBloc, StoreLocationState>(
                builder: (context, storeState) {
                  String storeName = 'No Store Selected';

                  if (storeState is StoreLocationLoaded &&
                      storeState.activeStore != null) {
                    storeName = storeState.activeStore!.name;
                  }

                  return StoreSelectorTile(
                    storeName: storeName,
                    onTap: () => _openStoreSelector(context),
                  );
                },
              ),

              const Divider(height: 24),

              /// ───────── App Preferences ─────────
              const SettingsSectionTitle(
                icon: Icons.settings_outlined,
                title: 'App Preferences',
              ),
              SettingsSwitchTile(
                icon: Icons.brightness_6_outlined,
                title: 'Enable Dark Mode',
                value: settings.darkMode,
                onChanged: (value) {
                  context.read<SettingsBloc>().add(ToggleDarkMode(value));
                  context.read<ThemeProvider>().setTheme(value);
                },
              ),

              const Divider(height: 32),

              /// ───────── Notifications ─────────
              const SettingsSectionTitle(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
              ),
              SettingsTile(
                icon: Icons.notifications_active_outlined,
                title: 'Manage Notifications',
                subtitle: 'Push alerts, Stock warnings, Daily summaries',
                onTap: () {
                  Navigator.push(
                    context,
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

              /// ───────── Inventory ─────────
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

              /// ───────── Security ─────────
              const SettingsSectionTitle(
                icon: Icons.security_outlined,
                title: 'Security & Support',
              ),
              SettingsTile(
                icon: Icons.cloud_sync_outlined,
                title: 'Backup & Restore',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BackupRestoreScreen(),
                    ),
                  );
                },
              ),

              const Divider(height: 32),

              /// ───────── Account ─────────
              SettingsTile(
                icon: Icons.person_outline,
                title: 'Account',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<AccountBloc>(),
                        child: const AccountScreen(),
                      ),
                    ),
                  );
                },
              ),

              const Divider(height: 32),

              /// ───────── Help ─────────
              const SettingsSectionTitle(
                icon: Icons.help_outline,
                title: 'Help & Support',
              ),
              SettingsTile(
                icon: Icons.help_outline,
                title: 'Help & Support',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HelpSupportScreen(),
                    ),
                  );
                },
              ),

              const Divider(height: 32),

              /// ───────── About ─────────
              SettingsTile(
                icon: Icons.info_outline,
                title: 'About',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AboutScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }

  /// ───────── Store Selector Bottom Sheet ─────────
  void _openStoreSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return BlocBuilder<StoreLocationBloc, StoreLocationState>(
          builder: (context, state) {
            if (state is! StoreLocationLoaded) {
              return const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            return ListView(
              children: state.stores.map((store) {
                final isActive =
                    state.activeStore?.id?.value == store.id?.value;

                return ListTile(
                  title: Text(store.name),
                  subtitle: Text(store.city),
                  trailing:
                      isActive ? const Icon(Icons.check) : null,
                  onTap: () {
                    context.read<StoreLocationBloc>().add(
                          SetActiveStoreLocationEvent(store.id!),
                        );
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            );
          },
        );
      },
    );
  }
}