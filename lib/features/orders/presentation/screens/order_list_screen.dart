import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:osm/features/orders/viewmodel/order_viewmodel.dart';
import 'package:isar/isar.dart';
// import 'package:osm/screens/add_order_screen.dart'; // Will be created later

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  void initState() {
    super.initState();
    // Load orders when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderViewModel>().loadOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<OrderViewModel>().loadOrders(),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Navigate to AddOrderScreen when it's implemented
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add Order Screen Coming Soon!')),
              );
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const AddOrderScreen()),
              // );
            },
          ),
        ],
      ),
      body: Consumer<OrderViewModel>(
        builder: (context, orderViewModel, child) {
          if (orderViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (orderViewModel.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error: ${orderViewModel.errorMessage}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            );
          } else if (orderViewModel.orders.isEmpty) {
            return const Center(child: Text('No orders found. Add some!'));
          } else {
            final orders = orderViewModel.orders;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: ListTile(
                    // Displaying some basic order info
                    title: Text('Order #${order.id} - ${order.status}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total: ₹${order.totalAmount.toStringAsFixed(2)}'),
                        Text(
                          'Date: ${DateFormat.yMMMd().format(order.orderDate)}',
                        ),
                        // You can load customer/prescription names here if you eager load them in ViewModel
                        // Example: Text('Customer: ${order.customer.value?.firstName ?? 'N/A'}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        // Implement a confirmation dialog before deleting
                        final confirmed = await _showDeleteConfirmationDialog(
                          context,
                          order.id,
                        );
                        if (confirmed) {
                          await orderViewModel.deleteOrder(order.id);
                        }
                      },
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Tapped on Order #${order.id}')),
                      );
                      // TODO: Navigate to OrderDetailScreen when implemented
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<bool> _showDeleteConfirmationDialog(
    BuildContext context,
    Id orderId,
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
