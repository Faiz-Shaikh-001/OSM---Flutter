import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/features/orders/domain/entities/order_item.dart';
import 'package:osm/features/orders/presentation/blocs/order_draft/order_draft_bloc.dart';
import 'package:osm/features/orders/presentation/value_objects/product_search_result.dart';

class ProductSearchTile extends StatelessWidget {
  final ProductSearchResult result;

  const ProductSearchTile({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(result.name),
      subtitle: Text(result.code),
      trailing: Text('₹${result.price.value.toStringAsFixed(0)}'),
      onTap: () {
        final orderItem = OrderItem(
          productID: result.id,
          productName: result.name,
          productCode: result.code,
          type: result.type.toOrderItemType(),
          quantity: 1,
          unitPrice: result.price,
        );

        context.read<OrderDraftBloc>().add(ItemAdded(orderItem));

        Navigator.pop(context);
      },
    );
  }
}
