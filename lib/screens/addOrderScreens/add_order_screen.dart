// lib/screens/add_order_screen.dart

import 'package:flutter/material.dart';
import 'package:osm/screens/addOrderScreens/customer_step_screen.dart';
import 'package:provider/provider.dart';
import 'package:osm/viewmodels/order_viewmodel.dart';
import 'product_selection_step.dart';
import 'payment_step.dart';
import './widgets/build_order_stepper.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  int _currentStep = 1;

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() => _currentStep++);
    }
  }

  void _previousStep() {
    if (_currentStep > 1) {
      setState(() => _currentStep--);
    } else {
      // If on the first step, ask to clear selection or pop
      final orderViewModel = context.read<OrderViewModel>();
      if (orderViewModel.selectedCustomer != null) {
        orderViewModel.resetForm();
      } else {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;

    switch (_currentStep) {
      case 1:
        bodyContent = CustomerStepScreen(onNext: _nextStep);
        break;
      case 2:
        bodyContent = ProductSelectionStep(onNext: _nextStep);
        break;
      case 3:
      default:
        bodyContent = const PaymentStep();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("New Order"),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: _previousStep,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: OrderStepper(currentStep: _currentStep),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: bodyContent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
