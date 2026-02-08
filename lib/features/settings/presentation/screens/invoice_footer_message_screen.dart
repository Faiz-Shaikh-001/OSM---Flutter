import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/settings_bloc.dart';
import '../bloc/settings_state.dart';
import '../bloc/settings_event.dart';

class InvoiceFooterMessageScreen extends StatefulWidget {
  const InvoiceFooterMessageScreen({super.key});

  @override
  State<InvoiceFooterMessageScreen> createState() =>
      _InvoiceFooterMessageScreenState();
}

class _InvoiceFooterMessageScreenState
    extends State<InvoiceFooterMessageScreen> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<SettingsBloc>().state;
    if (state is SettingsLoaded) {
      _controller.text = state.settings.invoiceFooterMessage;
    }
  }

  void _save() {
    context
        .read<SettingsBloc>()
        .add(UpdateInvoiceFooterMessage(_controller.text));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Footer Message'),
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
          maxLines: 4,
          decoration: const InputDecoration(
            labelText: 'Footer Message',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
