import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:osm/features/orders/domain/entities/order_item.dart';
import 'package:osm/features/orders/presentation/blocs/order_draft/order_draft_bloc.dart';
// import 'package:provider/provider.dart';
// import 'action_buttons.dart';

class SummaryBar extends StatelessWidget {
  final VoidCallback onNext;

  const SummaryBar({
    super.key,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDraftBloc, OrderDraftState>(
      builder: (context, state) {
        final items = state.draft.items;
        final totalAmount = state.draft.totalAmount;
        return Card(
          margin: const EdgeInsets.only(top: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (items.isNotEmpty) ...[
                  // const ActionButtons(),
                  const SizedBox(height: 16),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${items.length} Items',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          'Total: ₹${totalAmount.value.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    FilledButton(
                      onPressed: items.isNotEmpty ? onNext : null,
                      child: const Text('Proceed to Payment'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
