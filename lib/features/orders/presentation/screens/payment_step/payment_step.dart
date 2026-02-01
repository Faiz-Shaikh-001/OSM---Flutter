// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/features/orders/domain/entities/payment.dart';
import 'package:osm/features/orders/domain/entities/payment_enums.dart';
import 'package:osm/features/orders/presentation/blocs/order_draft/order_draft_bloc.dart';
import 'package:osm/features/orders/presentation/blocs/order_submission/order_submission_bloc.dart';

class PaymentStep extends StatefulWidget {
  const PaymentStep({super.key});

  @override
  State<PaymentStep> createState() => _PaymentStepState();
}

class _PaymentStepState extends State<PaymentStep> {
  PaymentMethod? _selectedMethod;

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderSubmissionBloc, OrderSubmissionState>(
      listener: (context, state) {
        if (state is OrderSubmissionLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is OrderSubmissionSuccess) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }

          context.read<OrderDraftBloc>().add(OrderDraftReset());

          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        }

        if (state is OrderSubmissionFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.failure.message)));
        }
      },
      child: BlocBuilder<OrderDraftBloc, OrderDraftState>(
        builder: (context, state) {
          return Column(
            children: [
              _OrderSummary(state),
              const Divider(),
              _paymentMethodSelector(),
              const Spacer(),
              _confirmButton(state),
            ],
          );
        },
      ),
    );
  }

  Widget _paymentMethodSelector() {
    return Column(
      children: PaymentMethod.values.map((method) {
        return RadioListTile<PaymentMethod>(
          value: method,
          groupValue: _selectedMethod,
          title: Text(method.name.toUpperCase()),
          onChanged: (value) {
            setState(() => _selectedMethod = value);
          },
        );
      }).toList(),
    );
  }

  Widget _confirmButton(OrderDraftState state) {
    final canPay = state.canSubmit && _selectedMethod != null;

    return Padding(
      padding: EdgeInsets.all(16),
      child: FilledButton(
        onPressed: canPay
            ? () => _confirmPayment(state)
            : () => debugPrint("Payment Cannot be made yet canPay=$canPay"),
        child: const Text('Confirm & Pay'),
      ),
    );
  }

  void _confirmPayment(OrderDraftState state) {
    final payment = Payment(
      paymentDate: DateTime.now(),
      amountPaid: state.draft.totalAmount,
      method: _selectedMethod!,
      status: PaymentStatus.completed,
    );

    context.read<OrderDraftBloc>().add(PaymentAdded(payment));

    context.read<OrderSubmissionBloc>().add(
      SubmitOrderDraft(state.draft.withPayment(payment)),
    );
  }
}

class _OrderSummary extends StatelessWidget {
  final OrderDraftState state;

  const _OrderSummary(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${state.draft.items.length} items',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Total: ₹${state.draft.totalAmount.value}',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
