import 'package:flutter/material.dart';
import 'package:osm/features/prescription/presentation/dto/prescription_with_doctor.dart';
import 'package:osm/features/prescription/presentation/screens/prescription_details_screen.dart';

class PrescriptionTimelineList extends StatelessWidget {
  final List<PrescriptionWithDoctor> prescriptions;

  const PrescriptionTimelineList({super.key, required this.prescriptions});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          ListTile(
            title: Text(
              "Prescriptions",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ...prescriptions.map((p) {
            return ListTile(
              title: Text(
                p.prescription.prescriptionDate
                    .toLocal()
                    .toString()
                    .split(' ')
                    .first,
              ),
              subtitle: Text(p.prescription.source.name.toUpperCase()),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        PrescriptionDetailsScreen(prescription: p.prescription),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
