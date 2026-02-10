import 'package:flutter/material.dart';
import 'package:osm/features/doctors/domain/entities/doctor.dart';
import 'package:osm/features/prescription/domain/entities/prescription.dart';
import 'package:osm/features/prescription/presentation/widgets/eye_power_table.dart';
import 'package:osm/features/prescription/presentation/widgets/prescription_header.dart';

class PrescriptionCard extends StatelessWidget {
  final Prescription prescription;
  final Doctor? doctor;
  final VoidCallback onUpdate;

  const PrescriptionCard({
    super.key,
    required this.prescription,
    required this.doctor,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrescriptionHeader(
              prescription: prescription,
              doctorName: doctor?.name,
            ),
            const SizedBox(height: 12),

            EyePowerTable(
              right: prescription.rightEye,
              left: prescription.leftEye,
            ),

            if (prescription.pd != null) ...[
              const Divider(),
              Text(
                'PD Left: ${prescription.pd != null ? prescription.pd!.left : '-'} mm  PD Right: ${prescription.pd != null ? prescription.pd!.right : '-'} mm',
              ),
            ],

            if (prescription.notes?.isNotEmpty == true) ...[
              const Divider(),
              Text(
                prescription.notes!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],

            const SizedBox(height: 12),

            Row(
              children: [
                const Spacer(),
                OutlinedButton(
                  onPressed: onUpdate,
                  child: const Text('Update'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
