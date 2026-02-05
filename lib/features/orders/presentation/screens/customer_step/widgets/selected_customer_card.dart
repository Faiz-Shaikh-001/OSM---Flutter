import 'package:flutter/material.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/customer/services/build_customer_image.dart';

class SelectedCustomerCard extends StatelessWidget {
  final Customer customer;
  final VoidCallback onRemove;

  const SelectedCustomerCard({
    super.key,
    required this.customer,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // 1. Header Section (Avatar + Name + Action)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                CircleAvatar(
                  radius: 28,
                  backgroundColor: colorScheme.primaryContainer,
                  backgroundImage: buildCustomerImage(customer.profileImageUrl),
                  child: customer.profileImageUrl == null
                      ? Text(
                          (customer.firstName.isNotEmpty
                                  ? customer.firstName[0]
                                  : "?")
                              .toUpperCase(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onPrimaryContainer,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 16),

                // Name & ID
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${customer.firstName} ${customer.lastName}',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'ID: ${customer.id}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade700,
                            fontFamily:
                                'Monospace', // Optional: makes ID look technical
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Remove Button
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.close),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.red.shade50,
                    foregroundColor: Colors.red,
                    padding: const EdgeInsets.all(8),
                    minimumSize: const Size(32, 32),
                  ),
                  tooltip: "Deselect Customer",
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // 2. Details Section (Grid Layout)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildGridRow(
                  context,
                  icon1: Icons.phone_outlined,
                  label1: "Phone",
                  value1: customer.primaryPhoneNumber,
                  icon2: Icons.email_outlined,
                  label2: "Email",
                  value2: customer.email ?? "N/A",
                ),
                const SizedBox(height: 16),
                _buildGridRow(
                  context,
                  icon1: Icons.location_city_outlined,
                  label1: "City",
                  value1: customer.city ?? "Unknown",
                  icon2: Icons.cake_outlined,
                  label2: "Age",
                  value2: customer.age?.toString() ?? "-",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper to build a 2-column row
  Widget _buildGridRow(
    BuildContext context, {
    required IconData icon1,
    required String label1,
    required String value1,
    required IconData icon2,
    required String label2,
    required String value2,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildDetailItem(context, icon1, label1, value1)),
        const SizedBox(width: 16),
        Expanded(child: _buildDetailItem(context, icon2, label2, value2)),
      ],
    );
  }

  Widget _buildDetailItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final isMissing = value == "N/A" || value == "-" || value == "Unknown";

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade500),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isMissing ? Colors.grey.shade400 : Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
