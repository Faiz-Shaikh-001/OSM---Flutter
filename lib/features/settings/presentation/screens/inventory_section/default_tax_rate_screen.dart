import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/settings_bloc.dart';
import '../../bloc/settings_state.dart';
import '../../bloc/settings_event.dart';

class DefaultTaxRateScreen extends StatefulWidget {
  const DefaultTaxRateScreen({super.key});

  @override
  State<DefaultTaxRateScreen> createState() => _DefaultTaxRateScreenState();
}

class _DefaultTaxRateScreenState extends State<DefaultTaxRateScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final state = context.read<SettingsBloc>().state;
    final rate =
        state is SettingsLoaded ? state.settings.defaultTaxRate : 0.0;

    _controller = TextEditingController(text: rate.toString());
  }

  void _save() {
    final value = double.tryParse(_controller.text);
    if (value == null || value < 0) return;

    context.read<SettingsBloc>().add(
          UpdateDefaultTaxRate(value),
        );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Default Tax Rate (GST)'),
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
          controller: _controller,
          keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'GST Percentage',
            suffixText: '%',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}