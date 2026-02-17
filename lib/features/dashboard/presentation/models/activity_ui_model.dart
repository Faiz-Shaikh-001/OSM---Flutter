import 'package:flutter/material.dart';
import 'package:osm/features/dashboard/domain/entities/activity.dart';

class ActivityUiModel {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final Color color;

  ActivityUiModel({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.color,
  });

  factory ActivityUiModel.fromEntity(Activity activity) {
    final String name =
        activity.metadata['customerName'] ??
        activity.metadata['name'] ??
        "Someone";
    final String brand = activity.metadata['brand'] != null
        ? "${activity.metadata['brand']} "
        : "";
    final String amount = activity.metadata['amount'] != null
        ? "₹${activity.metadata['amount']}"
        : "";

    switch (activity.type) {
      case ActivityType.newOrder:
        return ActivityUiModel(
          title: "New Order",
          subtitle: "Placed by $name for $amount",
          time: _formatTime(activity.occurredAt),
          icon: Icons.shopping_basket_rounded,
          color: Colors.blue,
        );

      case ActivityType.orderStatusUpdated:
        return ActivityUiModel(
          title: "Order Updated",
          subtitle: "Order for $name is now ${activity.metadata['status']}",
          time: _formatTime(activity.occurredAt),
          icon: Icons.assignment_turned_in_rounded,
          color: Colors.indigo,
        );

      case ActivityType.orderDeleted:
        return ActivityUiModel(
          title: "Order Removed",
          subtitle: "Order record for $name was deleted",
          time: _formatTime(activity.occurredAt),
          icon: Icons.delete_forever_rounded,
          color: Colors.red,
        );

      case ActivityType.paymentReceived:
        return ActivityUiModel(
          title: 'Payment Received',
          subtitle:
              '$amount from $name (${activity.metadata['method'] ?? 'Cash'})',
          time: _formatTime(activity.occurredAt),
          icon: Icons.account_balance_wallet_rounded,
          color: Colors.green,
        );

      case ActivityType.newStockAdded:
        return ActivityUiModel(
          title: 'Stock Added',
          subtitle: 'Added $brand$name to inventory',
          time: _formatTime(activity.occurredAt),
          icon: Icons.add_business_rounded,
          color: Colors.orange,
        );

      case ActivityType.stockUpdated:
        return ActivityUiModel(
          title: 'Stock Updated',
          subtitle: 'Updated details for $brand$name',
          time: _formatTime(activity.occurredAt),
          icon: Icons.inventory_2_rounded,
          color: Colors.purple,
        );

      case ActivityType.stockDeleted:
        return ActivityUiModel(
          title: 'Item Removed',
          subtitle: '$brand$name was deleted',
          time: _formatTime(activity.occurredAt),
          icon: Icons.delete_sweep_rounded,
          color: Colors.red,
        );

      case ActivityType.newCustomerAdded:
        return ActivityUiModel(
          title: 'New Customer',
          subtitle: '$name joined the store',
          time: _formatTime(activity.occurredAt),
          icon: Icons.person_add_alt_1_rounded,
          color: Colors.teal,
        );

      case ActivityType.customerUpdated:
        return ActivityUiModel(
          title: 'Profile Updated',
          subtitle: 'Details updated for $name',
          time: _formatTime(activity.occurredAt),
          icon: Icons.manage_accounts_outlined,
          color: Colors.indigo,
        );

      case ActivityType.customerDeleted:
        return ActivityUiModel(
          title: 'Customer Removed',
          subtitle: '$name was removed from records',
          time: _formatTime(activity.occurredAt),
          icon: Icons.person_off_rounded,
          color: Colors.blueGrey,
        );

      case ActivityType.lowStockAlert:
        return ActivityUiModel(
          title: 'Low Stock Alert',
          subtitle: '${activity.metadata['name']} is running low!',
          time: _formatTime(activity.occurredAt),
          icon: Icons.warning_amber_rounded,
          color: Colors.redAccent,
        );
    }
  }

  static String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';

    return '${time.day}/${time.month}';
  }
}
