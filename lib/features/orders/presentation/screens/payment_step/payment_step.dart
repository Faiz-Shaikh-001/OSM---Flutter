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
              _paymentMethodSelector(),
              const Divider(),
              _OrderSummary(state),
              const Spacer(),
              _confirmButton(state),
            ],
          );
        },
      ),
    );
  }

  Widget _paymentMethodSelector() {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Payment Method",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...PaymentMethod.values.map((method) {
                return RadioListTile<PaymentMethod>(
                  value: method,
                  groupValue: _selectedMethod,
                  title: Text(method.name.toUpperCase()),
                  dense: true,
                  onChanged: (value) {
                    setState(() => _selectedMethod = value);
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _confirmButton(OrderDraftState state) {
    final canPay = state.canSubmit && _selectedMethod != null;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: FilledButton.icon(
            icon: const Icon(Icons.check_circle_outline),
            onPressed: canPay ? () => _confirmPayment(state) : null,
            label: const Text("Confirm & Pay"),
          ),
        ),
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
      SubmitOrderDraft(state.draft.withPayment([payment])),
    );
  }
}

class _OrderSummary extends StatelessWidget {
  final OrderDraftState state;

  const _OrderSummary(this.state);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Summary",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(5),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 30,
                        child: Center(
                          child: Text("#", style: theme.textTheme.bodySmall),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Product",
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        child: Text(
                          "Qty",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(),

                ...state.draft.items.indexed.map((entry) {
                  final index = entry.$1 + 1;
                  final item = entry.$2;

                  return Row(
                    children: [
                      SizedBox(
                        width: 30,
                        child: Center(
                          child: Text(
                            index.toString(),
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          item.productName,
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        child: Text(
                          item.quantity.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  );
                }),

                const Divider(),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Amount"),
                      Text(
                        "₹${state.draft.totalAmount.value}",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
