import 'package:flutter/material.dart';
import 'package:osm/features/orders/presentation/enum/order_step.dart';

class OrderStepper extends StatelessWidget {
  final OrderStep currentStep;
  const OrderStepper({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return _buildOrderSteps();
  }

  int get _index => OrderStep.values.indexOf(currentStep);

  Widget _buildOrderSteps() {
    return Row(
      children: [
        _buildStep(stepNumber: 1, label: 'Customer'),
        _buildStepConnector(1),
        _buildStep(stepNumber: 2, label: 'Products'),
        _buildStepConnector(2),
        _buildStep(stepNumber: 3, label: 'Payment'),
      ],
    );
  }

  Widget _buildStep({required int stepNumber, required String label}) {
    bool isCompleted = stepNumber <= _index;
    bool isCurrent = stepNumber == _index + 1;

    Color stepColor = isCurrent
        ? Colors.blue
        : (isCompleted ? Colors.blue.shade200 : Colors.grey);
    Color textColor = isCurrent ? Colors.blue : Colors.grey;
    FontWeight fontWeight = isCurrent ? FontWeight.bold : FontWeight.normal;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(color: stepColor, shape: BoxShape.circle),
            child: Center(
              child: Text(
                '$stepNumber',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: textColor, fontWeight: fontWeight),
          ),
        ],
      ),
    );
  }

  Widget _buildStepConnector(int stepNumber) {
    bool isActive = _index >= stepNumber;

    return Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        height: 2.0,
        color: isActive ? Colors.blue : Colors.grey.shade200,
      ),
    );
  }
}
