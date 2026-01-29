import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/orders/domain/entities/order.dart';
import 'package:osm/features/orders/presentation/screens/order_detail_screen/order_detail_screen.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => context.read<OrderBloc>()..add(const LoadOrdersEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () =>
                  context.read<OrderBloc>().add(const LoadOrdersEvent()),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddOrderScreen()),
                );
              },
            ),
          ],
        ),
        body: BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state is OrderSuccess) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }

            if (state is OrderError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is OrderLoaded) {
                if (state.orders.isEmpty) {
                  return const _EmptyOrdersView();
                }

                return _OrdersListView(orders: state.orders);
              }

              if (state is OrderError) {
                return _ErrorView(message: state.message);
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class _OrdersListView extends StatelessWidget {
  final List<Order> orders;

  const _OrdersListView({required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text('Order #${order.id}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total: ₹${order.totalAmount}'),
                Text('Date: ${DateFormat.yMMMd().format(order.createdAt)}'),
                Text('Status: ${order.status.name}'),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                final confirmed = await _showDeleteConfirmationDialog(
                  context,
                  order.id,
                );

                if (confirmed && context.mounted) {
                  context.read<OrderBloc>().add(DeleteOrderEvent(order.id));
                }
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OrderDetailsScreen(order: order),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<bool> _showDeleteConfirmationDialog(
    BuildContext context,
    OrderId orderId,
  ) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text('Confirm Deletion'),
              content: Text(
                'Are you sure you want to permanently delete Order #$orderId? This action cannot be undone.',
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(false);
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  child: const Text('Delete'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(true);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }
}

class _EmptyOrdersView extends StatelessWidget {
  const _EmptyOrdersView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No orders found.\nTap + to create one.',
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          message,
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}


// return Scaffold(
//       appBar: AppBar(
//         title: const Text('Orders'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () => context.read<OrderViewModel>().loadOrders(),
//           ),
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const AddOrderScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Consumer<OrderViewModel>(
//         builder: (context, orderViewModel, child) {
//           if (orderViewModel.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (orderViewModel.errorMessage != null) {
//             return Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   'Error: ${orderViewModel.errorMessage}',
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(color: Colors.red, fontSize: 16),
//                 ),
//               ),
//             );
//           } else if (orderViewModel.orders.isEmpty) {
//             return const Center(child: Text('No orders found. Add some!'));
//           } else {
//             final orders = orderViewModel.orders;
//             return ListView.builder(
//               itemCount: orders.length,
//               itemBuilder: (context, index) {
//                 final order = orders[index];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(
//                     horizontal: 16.0,
//                     vertical: 8.0,
//                   ),
//                   child: ListTile(
//                     // Displaying some basic order info
//                     title: Text('Order #${order.id} - ${order.status}'),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Total: ₹${order.totalAmount.toStringAsFixed(2)}'),
//                         Text(
//                           'Date: ${DateFormat.yMMMd().format(order.orderDate)}',
//                         ),
//                         // You can load customer/prescription names here if you eager load them in ViewModel
//                         // Example: Text('Customer: ${order.customer.value?.firstName ?? 'N/A'}'),
//                       ],
//                     ),
//                     trailing: IconButton(
//                       icon: const Icon(Icons.delete, color: Colors.red),
//                       onPressed: () async {
//                         // Implement a confirmation dialog before deleting
//                         final confirmed = await _showDeleteConfirmationDialog(
//                           context,
//                           order.id,
//                         );
//                         if (confirmed) {
//                           await orderViewModel.deleteOrder(order.id);
//                         }
//                       },
//                     ),
//                     onTap: () {
//                       Navigator.of(context).push<OrderModel>(
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               OrderDetailsScreen(order: order),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );