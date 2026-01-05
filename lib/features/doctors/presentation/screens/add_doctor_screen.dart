import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/doctors/domain/entities/doctor.dart';
import 'package:osm/features/doctors/presentation/blocs/add_doctor/add_doctor_bloc.dart';

class AddDoctorScreen extends StatefulWidget {
  final StoreLocationId storeLocationId;

  const AddDoctorScreen({
    super.key,
    required this.storeLocationId,
  });

  @override
  State<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _designation = TextEditingController();
  final _hospital = TextEditingController();
  final _city = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _designation.dispose();
    _hospital.dispose();
    _city.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final doctor = Doctor(
      createdAt: DateTime.now(),
      name: _name.text.trim(),
      designation: _designation.text.trim(),
      hospital: _hospital.text.trim(),
      city: _city.text.trim(),
      isActive: true,
      storeLocationId: widget.storeLocationId,
    );

    context.read<AddDoctorBloc>().add(SubmitDoctor(doctor));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddDoctorBloc, AddDoctorState>(
      listener: (context, state) {
        if (state is AddDoctorSuccess) {
          final createdDoctor = Doctor(
            id: state.doctorId,
            createdAt: DateTime.now(),
            name: _name.text.trim(),
            designation: _designation.text.trim(),
            hospital: _hospital.text.trim(),
            city: _city.text.trim(),
            isActive: true,
            storeLocationId: widget.storeLocationId,
          );

          Navigator.pop(context, createdDoctor);
        }

        if (state is AddDoctorFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Doctor')),
        floatingActionButton:
            BlocBuilder<AddDoctorBloc, AddDoctorState>(
          builder: (context, state) {
            final isLoading = state is AddDoctorSubmitting;

            return FloatingActionButton.extended(
              onPressed: isLoading ? null : _submit,
              label: const Text('Save'),
              icon: isLoading
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.save),
            );
          },
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _field(_name, 'Doctor Name'),
              _field(_designation, 'Designation'),
              _field(_hospital, 'Hospital / Clinic'),
              _field(_city, 'City'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(TextEditingController c, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: c,
        decoration: InputDecoration(labelText: label),
        validator: (v) =>
            v == null || v.isEmpty ? 'Required' : null,
      ),
    );
  }
}
