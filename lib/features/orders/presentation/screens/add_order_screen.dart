import 'package:flutter/material.dart';
import 'package:osm/features/orders/presentation/screens/customer_step/customer_step_screen.dart';
import 'package:osm/features/orders/presentation/screens/payment_step/payment_step.dart';
import 'package:osm/features/orders/presentation/screens/product_step/product_selection_step.dart';
import 'package:osm/features/orders/presentation/widgets/order_stepper.dart';
import 'package:osm/features/orders/viewmodel/order_viewmodel.dart';
import 'package:provider/provider.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  int _currentStep = 1;

  void _onOrderCompleted() {
    final order = context.read<OrderViewModel>().currentOrder;
    Navigator.pop(context, order);
  }

  void _goToPreviousStep() {
    if (_currentStep > 1) {
      setState(() => _currentStep -= 1);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;
    String stepTitle;

    if (_currentStep == 1) {
      bodyContent = CustomerStepScreen(
        onNext: () => setState(() => _currentStep = 2),
      );
      stepTitle = "Select Customer";
    } else if (_currentStep == 2) {
      bodyContent = ProductSelectionStep(
        onNext: () => setState(() => _currentStep = 3),
      );
      stepTitle = "Select Products";
    } else {
      bodyContent = PaymentStep(
        onFinish: _onOrderCompleted,
      );
      stepTitle = "Payment";
    }

    return Scaffold(
      appBar: AppBar(
        title:  Column(
          children: [
            const Text("New Order"),
            Text(
              stepTitle,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: _goToPreviousStep,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: OrderStepper(currentStep: _currentStep),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: bodyContent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
