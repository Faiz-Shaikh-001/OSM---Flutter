import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/settings_bloc.dart';
import '../../bloc/settings_state.dart';
import '../../bloc/settings_event.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is! SettingsLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final settings = state.settings;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // ───────────────── Master Switch ─────────────────
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest,
                ),
                child: SwitchListTile(
                  secondary:
                      const Icon(Icons.notifications_active_outlined),
                  title: const Text('Allow Notifications'),
                  subtitle:
                      const Text('Master switch for all alerts'),
                  value: settings.allowNotifications,
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(
                          TogglePushNotifications(value),
                        );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // ───────────────── Alert Types ─────────────────
              const Text(
                'Alert Types',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              SwitchListTile(
                title: const Text('Low Stock Alerts'),
                subtitle: const Text(
                  'Get notified when items reach minimum quantity',
                ),
                value: settings.lowStockAlerts,
                onChanged: (value) {
                  context.read<SettingsBloc>().add(
                        ToggleLowStockAlerts(value),
                      );
                },
              ),

              SwitchListTile(
                title: const Text('New Order Notifications'),
                subtitle: const Text(
                  'Instant alerts for incoming orders',
                ),
                value: settings.newOrderNotifications,
                onChanged: (value) {
                  context.read<SettingsBloc>().add(
                        ToggleNewOrderNotifications(value),
                      );
                },
              ),

              SwitchListTile(
                title: const Text('Daily Summary'),
                subtitle: const Text(
                  'Receive sales report at 11:59 PM',
                ),
                value: settings.dailySummary,
                onChanged: (value) {
                  context.read<SettingsBloc>().add(
                        ToggleDailySummary(value),
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
