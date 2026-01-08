import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/features/orders/presentation/blocs/order_draft/order_draft_bloc.dart';
import 'package:osm/features/orders/presentation/blocs/order_submission/order_submission_bloc.dart';

class PaymentStep extends StatelessWidget {
  const PaymentStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDraftBloc, OrderDraftState>(
      builder: (context, state) {
        return Column(
          children: [
            Text('Total: ₹${state.draft.totalAmount.value}'),
            ElevatedButton(
              onPressed: state.canSubmit
                  ? () {
                      context.read<OrderSubmissionBloc>().add(
                            SubmitOrderDraft(state.draft),
                          );
                    }
                  : null,
              child: const Text('Submit Order'),
            ),
          ],
        );
      },
    );
  }
}
