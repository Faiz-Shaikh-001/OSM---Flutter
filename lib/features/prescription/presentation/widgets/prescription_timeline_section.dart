import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/prescription/domain/repositories/prescription_repository.dart';
import 'package:osm/features/prescription/domain/usecases/get_prescription_history.dart';
import 'package:osm/features/prescription/presentation/bloc/prescription_timeline/prescription_timeline_bloc.dart';
import 'package:osm/features/prescription/presentation/widgets/prescription_timeline_list.dart';

class PrescriptionTimelineSection extends StatelessWidget {
  final CustomerId customerId;
  const PrescriptionTimelineSection({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrescriptionTimelineBloc(
        getPrescriptionHistory: GetPrescriptionHistory(context.read<PrescriptionRepository>()),
      )..add(LoadPrescriptionTimeline(customerId)),
      child: const _PrescriptionTimelineView(),
    );
  }
}

class _PrescriptionTimelineView extends StatelessWidget {
  const _PrescriptionTimelineView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrescriptionTimelineBloc, PrescriptionTimelineState>(
      builder: (context, state) {
        if (state is PrescriptionTimelineLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is PrescriptionTimelineError) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text(state.message),
          );
        }

        if (state is PrescriptionTimelineLoaded) {
          if (state.prescriptions.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Text('No prescriptions yet'),
            );
          }

          return PrescriptionTimelineList(prescriptions: state.prescriptions);
        }

        return const SizedBox.shrink();
      },
    );
  }
}
