// file: selected_customer_card.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:osm/data/models/customer_model.dart';

class SelectedCustomerCard extends StatelessWidget {
  final CustomerModel customer;
  final VoidCallback onRemove;

  const SelectedCustomerCard({
    super.key,
    required this.customer,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: colorScheme.primaryContainer,
                  backgroundImage: customer.profileImageUrl.startsWith('http')
                      ? NetworkImage(customer.profileImageUrl)
                      : FileImage(File(customer.profileImageUrl))
                            as ImageProvider,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${customer.firstName} ${customer.lastName}',
                        style: textTheme.headlineSmall,
                      ),
                      Text(
                        'ID: ${customer.id}',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onRemove,
                  tooltip: 'Deselect Customer',
                ),
              ],
            ),
            const Divider(height: 32),
            _buildDetailRow(
              context,
              Icons.phone,
              'Phone',
              customer.primaryPhoneNumber,
            ),
            _buildDetailRow(
              context,
              Icons.location_city,
              'City',
              customer.city,
            ),
            _buildDetailRow(
              context,
              Icons.cake,
              'Age',
              customer.age.toString(),
            ),
            if (customer.email?.isNotEmpty ?? false)
              _buildDetailRow(context, Icons.email, 'Email', customer.email!),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 16),
          Text('$label: ', style: textTheme.bodyLarge),
          Expanded(
            child: Text(
              value,
              style: textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
