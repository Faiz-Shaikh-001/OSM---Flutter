import 'package:flutter/material.dart';
import 'package:osm/features/orders/presentation/screens/customer_step/customer_step_screen.dart';
import 'package:osm/features/orders/presentation/screens/payment_step/payment_step.dart';
import 'package:osm/features/orders/presentation/screens/product_step/product_selection_step.dart';
import 'package:osm/features/orders/presentation/widgets/order_stepper.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  int _currentStep = 1;

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;
    if (_currentStep == 1) {
      bodyContent = CustomerStepScreen(
        onNext: () => setState(() => _currentStep = 2),
      );
    } else if (_currentStep == 2) {
      bodyContent = ProductSelectionStep(
        onNext: () => setState(() => _currentStep = 3),
      );
    } else {
      bodyContent = const PaymentStep();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("New Order"),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            if (_currentStep > 1) {
              setState(() => _currentStep -= 1);
            } else {
              Navigator.pop(context);
            }
          },
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
