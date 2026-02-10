import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osm/features/orders/domain/entities/order.dart';
import 'package:osm/features/orders/domain/entities/order_enums.dart';

class StatusBanner extends StatelessWidget {
  final Order order;
  const StatusBanner({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData icon;

    switch (order.status) {
      case OrderStatus.completed:
        color = Colors.green;
        icon = Icons.check_circle;
        break;
      case OrderStatus.pendingPayment:
        color = Colors.orange;
        icon = Icons.pending;
        break;
      case OrderStatus.cancelled:
        color = Colors.red;
        icon = Icons.cancel;
        break;
      default:
        color = Colors.blue;
        icon = Icons.edit_note;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order Status: ${order.status.label}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 16,
                ),
              ),
              order.status == OrderStatus.completed
                  ? Text(
                      "Completed at ${DateFormat.yMMMd().format(order.completedAt!)}",
                      style: TextStyle(
                        color: color.withValues(alpha: 0.8),
                        fontSize: 13,
                      ),
                    )
                  : Text(
                      "Created on ${DateFormat.yMMMd().format(order.createdAt)}",
                      style: TextStyle(
                        color: color.withValues(alpha: 0.8),
                        fontSize: 13,
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
