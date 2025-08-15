import 'package:flutter/material.dart';

class OrderStepper extends StatelessWidget {
  final int currentStep;
  const OrderStepper({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return _buildOrderSteps();
  }

  Widget _buildOrderSteps() {
    return Row(
      children: [
        _buildStep(stepNumber: 1, label: 'Customer'),
        _buildStepConnector(1),
        _buildStep(stepNumber: 2, label: 'Products'),
        _buildStepConnector(2),
        _buildStep(stepNumber: 3, label: 'Payment'),
        _buildStepConnector(3),
      ],
    );
  }

  Widget _buildStep({required int stepNumber, required String label}) {
    bool isCompleted = stepNumber < currentStep;
    bool isCurrent = stepNumber == currentStep;

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
    bool isActive = currentStep >= stepNumber;

    return Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        height: 2.0,
        color: isActive ? Colors.blue : Colors.grey.shade200,
      ),
    );
  }
}
