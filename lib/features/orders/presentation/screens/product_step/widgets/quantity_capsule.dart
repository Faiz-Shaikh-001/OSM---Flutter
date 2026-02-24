// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class QuantityCapsule extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantityCapsule({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18), // Pill shape
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decrement Button
          _CapsuleButton(
            icon: Icons.remove,
            onTap: onDecrement,
            isEnabled: quantity > 1, // Optional: Disable if 1 to prevent accidental delete
          ),
          
          // Value Display
          Container(
            constraints: const BoxConstraints(minWidth: 32),
            alignment: Alignment.center,
            child: Text(
              '$quantity',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),

          // Increment Button
          _CapsuleButton(
            icon: Icons.add,
            onTap: onIncrement,
            isEnabled: true,
          ),
        ],
      ),
    );
  }
}

class _CapsuleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isEnabled;

  const _CapsuleButton({
    required this.icon,
    required this.onTap,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled ? onTap : null,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Icon(
          icon,
          size: 16,
          color: isEnabled ? Colors.black87 : Colors.grey.shade300,
        ),
      ),
    );
  }
}