import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/settings_bloc.dart';
import '../../bloc/settings_state.dart';

import 'stock_threshold_screen.dart';
import 'default_tax_rate_screen.dart';
import 'default_discount_rate_screen.dart';
import 'invoice_footer_message_screen.dart';

class InventorySettingsScreen extends StatelessWidget {
  const InventorySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Configuration'),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is! SettingsLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final settings = state.settings;

          return ListView(
            children: [
              _InventoryTile(
                icon: Icons.shopping_cart_outlined,
                title: 'Stock Warning Threshold',
                subtitle: settings.stockThresholdLabel,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<SettingsBloc>(),
                        child: const StockThresholdScreen(),
                      ),
                    ),
                  );
                },
              ),

              const Divider(height: 1),

              _InventoryTile(
                icon: Icons.percent_outlined,
                title: 'Default Tax Rate (GST)',
                subtitle: settings.taxRateLabel,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<SettingsBloc>(),
                        child: const DefaultTaxRateScreen(),
                      ),
                    ),
                  );
                },
              ),

              const Divider(height: 1),

              _InventoryTile(
                icon: Icons.discount_outlined,
                title: 'Default Discount Rate',
                subtitle: settings.discountRateLabel,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<SettingsBloc>(),
                        child: const DefaultDiscountRateScreen(),
                      ),
                    ),
                  );
                },
              ),

              const Divider(height: 1),

              _InventoryTile(
                icon: Icons.receipt_long_outlined,
                title: 'Invoice Footer Message',
                subtitle: settings.footerMessageLabel,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<SettingsBloc>(),
                        child: const InvoiceFooterMessageScreen(),
                      ),
                    ),
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

class _InventoryTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _InventoryTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
