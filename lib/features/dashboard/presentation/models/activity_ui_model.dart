import 'package:flutter/material.dart';
import 'package:osm/features/dashboard/domain/entities/activity.dart';

class ActivityUiModel {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;

  ActivityUiModel({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
  });

  factory ActivityUiModel.fromEntity(Activity activity) {
    switch (activity.type) {
      case ActivityType.newOrder:
        return ActivityUiModel(
          title: "New Order Created",
          subtitle: "Order ID: ${activity.metadata['orderId'] ?? ''}",
          time: _formatTime(activity.occurredAt),
          icon: Icons.shopping_cart,
        );

      case ActivityType.paymentReceived:
        return ActivityUiModel(
          title: 'Payment Received',
          subtitle: 'Amount: ₹${activity.metadata['amount'] ?? ''}',
          time: _formatTime(activity.occurredAt),
          icon: Icons.payments,
        );

      default:
        return ActivityUiModel(
          title: 'Activity',
          subtitle: '',
          time: _formatTime(activity.occurredAt),
          icon: Icons.info,
        );
    }
  }

  static String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hr ago';

    return '${time.day}/${time.month}/${time.year}';
  }
}
