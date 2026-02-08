import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_state.dart';
import '../bloc/settings_event.dart';

class StockThresholdScreen extends StatefulWidget {
  const StockThresholdScreen({super.key});

  @override
  State<StockThresholdScreen> createState() => _StockThresholdScreenState();
}

class _StockThresholdScreenState extends State<StockThresholdScreen> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    final settings =
        (context.read<SettingsBloc>().state as SettingsLoaded).settings;
    controller = TextEditingController(
      text: settings.stockWarningThreshold.toString(),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _save() {
    final value = int.tryParse(controller.text);
    if (value == null || value < 0) return;

    context.read<SettingsBloc>().add(
          UpdateStockThreshold(value),
        );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Warning Threshold'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _save,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Minimum Stock Quantity',
            helperText: 'Alert when stock falls below this number',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
