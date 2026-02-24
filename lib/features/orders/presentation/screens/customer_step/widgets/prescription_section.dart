import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/doctors/domain/entities/doctor.dart';
import 'package:osm/features/orders/presentation/blocs/order_draft/order_draft_bloc.dart';
import 'package:osm/features/prescription/domain/entities/prescription.dart';
import 'package:osm/features/prescription/presentation/bloc/prescription_timeline/prescription_timeline_bloc.dart';
import 'package:osm/features/prescription/presentation/screens/add_prescription_screen.dart';
import 'package:osm/features/prescription/presentation/widgets/prescription_card.dart';

class PrescriptionSection extends StatefulWidget {
  final Customer customer;
  const PrescriptionSection({super.key, required this.customer});

  @override
  State<PrescriptionSection> createState() => _PrescriptionSectionState();
}

class _PrescriptionSectionState extends State<PrescriptionSection> {
  CustomerId? _lastLoadedCustomer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final customerId = context.read<OrderDraftBloc>().state.draft.customerId;

    if (customerId != null && customerId != _lastLoadedCustomer) {
      _lastLoadedCustomer = customerId;

      context.read<PrescriptionTimelineBloc>().add(
        LoadPrescriptionTimeline(customerId),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrescriptionTimelineBloc, PrescriptionTimelineState>(
      builder: (context, state) {
        if (state is PrescriptionTimelineLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is PrescriptionTimelineError) {
          return Center(child: Text(state.message));
        }

        if (state is PrescriptionTimelineLoaded) {
          final prescriptions = state.prescriptions;

          if (prescriptions.isNotEmpty) {
            final selectedId = context
                .read<OrderDraftBloc>()
                .state
                .draft
                .prescriptionId;

            if (selectedId == null) {
              context.read<OrderDraftBloc>().add(
                PrescriptionSelected(prescriptions.first.prescription),
              );
            }

            return _PrescriptionView(
              prescriptions.first.prescription,
              prescriptions.first.doctor,
              () => _addPrescription(context),
            );
          }

          return _NoPrescriptionView(() => _addPrescription(context));
        }

        return const Text("Something went wrong");
      },
    );
  }

  Future<void> _addPrescription(BuildContext context) async {
    final prescription = await Navigator.push<Prescription>(
      context,
      MaterialPageRoute(
        builder: (_) => AddPrescriptionScreen(customerId: widget.customer.id!),
      ),
    );

    if (prescription == null || !context.mounted) return;

    context.read<PrescriptionTimelineBloc>().add(
      LoadPrescriptionTimeline(widget.customer.id!),
    );

    context.read<OrderDraftBloc>().add(PrescriptionSelected(prescription));
  }
}

class _NoPrescriptionView extends StatelessWidget {
  final VoidCallback addPrescription;

  const _NoPrescriptionView(this.addPrescription);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(child: const Text("No Prescription Yet")),
            ),

            Row(
              children: [
                Spacer(),
                OutlinedButton(
                  onPressed: addPrescription,
                  child: Text("Add Prescription"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PrescriptionView extends StatelessWidget {
  final Prescription prescription;
  final Doctor? doctor;
  final VoidCallback addPrescription;
  const _PrescriptionView(this.prescription, this.doctor, this.addPrescription);

  @override
  Widget build(BuildContext context) {
    return PrescriptionCard(
      prescription: prescription,
      doctor: doctor,
      onUpdate: addPrescription,
    );
  }
}
