import 'package:flutter/material.dart';
import 'package:osm/features/prescription/domain/entities/prescription.dart';
import 'package:osm/features/prescription/domain/entities/prescription_source.dart';

class PrescriptionHeader extends StatelessWidget {
  final Prescription prescription;
  final String? doctorName;

  const PrescriptionHeader({
    super.key,
    required this.prescription,
    required this.doctorName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          children: [
            Text(
              'Prescription • ${_formatDate(prescription.prescriptionDate)}',
              style: theme.textTheme.titleMedium,
            ),
            const Spacer(),
            _SourceBadge(source: prescription.source),
          ],
        ),

        if (doctorName != null) ...[
          const SizedBox(height: 4),
          Text(
            'Dr. $doctorName',
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ],
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}

class _SourceBadge extends StatelessWidget {
  final PrescriptionSource source;
  const _SourceBadge({required this.source});

  @override
  Widget build(BuildContext context) {
    final isExternal = source == PrescriptionSource.external;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isExternal ? Colors.orange.shade100 : Colors.green.shade100,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        isExternal ? 'EXTERNAL' : 'IN-STORE',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isExternal ? Colors.orange.shade800 : Colors.green.shade800,
        ),
      ),
    );
  }
}
