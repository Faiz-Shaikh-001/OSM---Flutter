import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/features/doctors/domain/repositories/doctor_repository.dart';
import 'package:osm/features/doctors/domain/usecases/get_doctor_by_id.dart';
import 'package:osm/features/doctors/presentation/blocs/doctor_details/doctor_details_bloc.dart';
import 'package:osm/features/prescription/domain/entities/prescription.dart';
import 'package:osm/features/prescription/domain/entities/prescription_source.dart';

class PrescriptionDetailsScreen extends StatelessWidget {
  final Prescription prescription;

  const PrescriptionDetailsScreen({super.key, required this.prescription});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prescription Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _section(
              title: 'Prescription Info',
              children: [
                _infoTile(
                  'Prescription Date',
                  _formatDate(prescription.prescriptionDate),
                ),
                _infoTile('Source', prescription.source.name.toUpperCase()),
                _infoTile('Created At', _formatDate(prescription.createdAt)),
              ],
            ),

            _eyeSection('Right Eye (OD)', prescription.rightEye),
            _eyeSection('Left Eye (OS)', prescription.leftEye),

            if (prescription.pd != null)
              _section(
                title: 'Pupillary Distance',
                children: [
                  _infoTile('Left PD', prescription.pd!.left.toString()),
                  _infoTile('Right PD', prescription.pd!.right.toString()),
                ],
              ),

            if (prescription.source == PrescriptionSource.external &&
                prescription.doctorId != null)
              BlocProvider(
                create: (context) {
                  final repo = context.read<DoctorRepository>();
                  return DoctorDetailsBloc(getDoctorById: GetDoctorById(repo))
                    ..add(LoadDoctorDetails(prescription.doctorId!));
                },
                child: _DoctorDetailsSection(),
              ),

            if (prescription.notes != null && prescription.notes!.isNotEmpty)
              _section(
                title: 'Notes',
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      prescription.notes!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _eyeSection(String title, eye) {
    return _section(
      title: title,
      children: [
        _infoTile('Sphere', eye.sphere.toString()),
        if (eye.cylinder != null)
          _infoTile('Cylinder', eye.cylinder.toString()),
        if (eye.axis != null) _infoTile('Axis', eye.axis.toString()),
        if (eye.add != null) _infoTile('Add', eye.add.toString()),
      ],
    );
  }

  Widget _infoTile(String label, String value) {
    return ListTile(
      title: Text(label),
      trailing: Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _section({required String title, required List<Widget> children}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          ListTile(
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          const Divider(height: 1),
          ...children,
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return date.toLocal().toString().split(' ').first;
  }
}

class _DoctorDetailsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: BlocBuilder<DoctorDetailsBloc, DoctorDetailsState>(
        builder: (context, state) {
          if (state is DoctorDetailsLoading) {
            return const ListTile(
              title: Text('Doctor'),
              subtitle: Text('Loading...'),
            );
          }

          if (state is DoctorDetailsLoaded) {
            final doctor = state.doctor;

            return Column(
              children: [
                const ListTile(
                  title: Text(
                    'Doctor',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(doctor.name),
                  subtitle: Text(doctor.designation),
                ),
                ListTile(
                  leading: const Icon(Icons.local_hospital),
                  title: Text(doctor.hospital),
                  subtitle: Text(doctor.city),
                ),
                if (!doctor.isActive)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Inactive doctor',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            );
          }

          if (state is DoctorDetailsError) {
            return ListTile(
              title: const Text('Doctor'),
              subtitle: Text(state.message),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
