import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/settings_bloc.dart';
import '../../bloc/settings_state.dart';
import '../../bloc/settings_event.dart';

class DefaultDiscountRateScreen extends StatefulWidget {
  const DefaultDiscountRateScreen({super.key});

  @override
  State<DefaultDiscountRateScreen> createState() =>
      _DefaultDiscountRateScreenState();
}

class _DefaultDiscountRateScreenState
    extends State<DefaultDiscountRateScreen> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<SettingsBloc>().state;
    if (state is SettingsLoaded) {
      _controller.text = state.settings.discountRate.toString();
    }
  }

  void _save() {
    final value = double.tryParse(_controller.text);
    if (value == null) return;

    context.read<SettingsBloc>().add(UpdateDiscountRate(value));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Default Discount Rate'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _save,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Discount (%)',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
