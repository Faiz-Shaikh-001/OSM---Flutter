import 'package:flutter/material.dart';
import 'package:osm/features/orders/domain/entities/order_item.dart';
import 'package:osm/features/orders/presentation/blocs/order_draft/order_draft_bloc.dart';
import 'package:provider/provider.dart';

class QuantityStepper extends StatelessWidget {
  final OrderItem item;
  const QuantityStepper({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton.filledTonal(
          icon: const Icon(Icons.remove),
          onPressed: () => context.read<OrderDraftBloc>().add(ItemQuantityDecreased(item.productID)),
        ),
        SizedBox(
          width: 40,
          child: Text(
            '${item.quantity}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        IconButton.filledTonal(
          icon: const Icon(Icons.add),
          onPressed: () => context.read<OrderDraftBloc>().add(ItemQuantityIncreased(item.productID)),
        ),
      ],
    );
  }
}
