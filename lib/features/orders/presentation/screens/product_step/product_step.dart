import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/value_objects/money.dart';
import 'package:osm/features/orders/domain/entities/order_item.dart';
import 'package:osm/features/orders/domain/entities/order_item_type.dart';
import 'package:osm/features/orders/presentation/blocs/order_draft/order_draft_bloc.dart';

class ProductStep extends StatelessWidget {
  const ProductStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDraftBloc, OrderDraftState>(
      builder: (context, state) {
        return Column(
          children: [
            ...state.draft.items.map(
              (item) => ListTile(
                title: Text(item.productName),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    final index = state.draft.items.indexOf(item);
                    context
                        .read<OrderDraftBloc>()
                        .add(ItemRemoved(index));
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<OrderDraftBloc>().add(
                  ItemAdded(
                    OrderItem(
                      productName: 'Frame A',
                      productCode: 'FR123',
                      type: OrderItemType.frame,
                      quantity: 1,
                      unitPrice: Money(2000),
                    ),
                  ),
                );
              },
              child: const Text('Add Product'),
            ),
            Text('Total: ₹${state.draft.totalAmount.value}'),
          ],
        );
      },
    );
  }
}
