import 'package:flutter/material.dart';
import 'package:osm/core/services/order_creation_service.dart';
import 'package:osm/features/orders/data/models/order_model_enums.dart';
import 'package:osm/features/orders/data/repositories/order_repository.dart';
import 'package:osm/features/orders/viewmodel/order_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:osm/features/orders/data/models/payment_model.dart';
import 'package:osm/features/orders/data/repositories/payment_repository.dart';
import 'package:osm/core/services/isar_service.dart';

class PaymentStep extends StatefulWidget {
  final VoidCallback onFinish;

  const PaymentStep({super.key, required this.onFinish});

  @override
  State<PaymentStep> createState() => _PaymentStepState();
}

class _PaymentStepState extends State<PaymentStep> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  String _method = "Cash";
  bool _isLoading = false;

  late final OrderCreationService _orderCreationService;

  @override
  void initState() {
    super.initState();
    _orderCreationService = OrderCreationService(IsarService());
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _savePayment() async {
    if (!_formKey.currentState!.validate()) return;

    final orderVM = context.read<OrderViewModel>();

    setState(() {
      _isLoading = true;
    });

    try {
      final customer = orderVM.selectedCustomer;
      final orderItems = orderVM.getOrderItems();
      final totalAmount = orderVM.totalPrice;

      if (customer == null) {
        throw Exception("Customer is required");
      }

      if (orderItems.isEmpty) {
        throw Exception("At least one product is required");
      }

      final paymentAmount = double.parse(_amountController.text.trim());
      if (paymentAmount <= 0) {
        throw Exception("Payment amount mus tbe greater than 0");
      }

      final payment = PaymentModel(
        paymentDate: DateTime.now(),
        amountPaid: paymentAmount,
        paymentMethod: _method,
        status: OrderStatus.pending.name,
      );

      final order = await _orderCreationService.createCompleteOrder(
        customer: customer,
        items: orderItems,
        totalAmount: totalAmount,
        payment: payment,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Order created successfully!")),
        );

        // Clear the current order data
        orderVM.clearCurrentOrder();

        // Navigate back
        widget.onFinish();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Order creation error: $e")));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderVM = context.watch<OrderViewModel>();
    final totalAmount = orderVM.totalPrice;
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment Summary",
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Order Summary
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Items:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("${orderVM.totalItems}"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Amount:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "₹${totalAmount.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            Text(
              "Add Payment",
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount Paid",
                prefixIcon: Icon(Icons.currency_rupee),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter payment amount";
                }
                final num? parsed = num.tryParse(value);
                if (parsed == null || parsed <= 0) {
                  return "Enter a valid amount";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: _method,
              items: const [
                DropdownMenuItem(value: "Cash", child: Text("Cash")),
                DropdownMenuItem(value: "Card", child: Text("Card")),
                DropdownMenuItem(value: "UPI", child: Text("UPI")),
                DropdownMenuItem(value: "Other", child: Text("Other")),
              ],
              onChanged: (val) => setState(() => _method = val!),
              decoration: const InputDecoration(
                labelText: "Payment Method",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _savePayment,
                icon: _isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.check_circle),
                label: Text(_isLoading ? "Saving..." : "Confirm Payment"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
