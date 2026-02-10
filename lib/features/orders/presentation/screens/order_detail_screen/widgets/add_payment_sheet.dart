import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/value_objects/money.dart';
import 'package:osm/features/orders/domain/entities/order.dart';
import 'package:osm/features/orders/domain/entities/payment.dart';
import 'package:osm/features/orders/domain/entities/payment_enums.dart';
import 'package:osm/features/orders/presentation/blocs/order_submission/order_submission_bloc.dart';

class AddPaymentSheet extends StatefulWidget {
  final Order order;
  final VoidCallback onPaymentSuccess;

  const AddPaymentSheet({
    super.key,
    required this.order,
    required this.onPaymentSuccess,
  });

  @override
  State<AddPaymentSheet> createState() => AddPaymentSheetState();
}

class AddPaymentSheetState extends State<AddPaymentSheet> {
  final _amountController = TextEditingController();
  PaymentMethod _selectedMethod = PaymentMethod.cash;

  @override
  void initState() {
    super.initState();
    _amountController.text = widget.order.pendingAmount.value.toString();
  }

  void _submitPayment() async {
    final amountVal = double.tryParse(_amountController.text);
    if (amountVal == null || amountVal <= 0) return;

    final payment = Payment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      paymentDate: DateTime.now(),
      amountPaid: Money(amountVal),
      method: _selectedMethod,
      status: PaymentStatus.completed,
    );

    context.read<OrderSubmissionBloc>().add(
      AddOrderPayment(order: widget.order, payment: payment),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderSubmissionBloc, OrderSubmissionState>(
      listener: (context, state) {
        if (state is OrderSubmissionSuccess) {
          widget.onPaymentSuccess();
        } else if (state is OrderSubmissionFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.failure.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is OrderSubmissionLoading;
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Record Payment",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                enabled: !isLoading,
                decoration: const InputDecoration(
                  labelText: "Amount",
                  prefixText: "₹ ",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<PaymentMethod>(
                initialValue: _selectedMethod,
                decoration: const InputDecoration(
                  labelText: "Payment Method",
                  border: OutlineInputBorder(),
                ),
                items: PaymentMethod.values
                    .map(
                      (m) => DropdownMenuItem(
                        value: m,
                        child: Text(m.name.capitalize),
                      ),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _selectedMethod = val!),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _submitPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text("Confirm Payment"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
