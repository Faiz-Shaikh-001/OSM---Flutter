import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/features/doctors/domain/entities/doctor.dart';
import 'package:osm/features/doctors/presentation/blocs/edit_doctor/edit_doctor_bloc.dart';

class EditDoctorScreen extends StatefulWidget {
  final Doctor doctor;

  const EditDoctorScreen({super.key, required this.doctor});

  @override
  State<EditDoctorScreen> createState() => _EditDoctorScreenState();
}

class _EditDoctorScreenState extends State<EditDoctorScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _name;
  late TextEditingController _designation;
  late TextEditingController _hospital;
  late TextEditingController _city;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.doctor.name);
    _designation = TextEditingController(text: widget.doctor.designation);
    _hospital = TextEditingController(text: widget.doctor.hospital);
    _city = TextEditingController(text: widget.doctor.city);
  }

  @override
  void dispose() {
    _name.dispose();
    _designation.dispose();
    _hospital.dispose();
    _city.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final updated = Doctor(
      id: widget.doctor.id,
      createdAt: widget.doctor.createdAt,
      name: _name.text.trim(),
      designation: _designation.text.trim(),
      hospital: _hospital.text.trim(),
      city: _city.text.trim(),
      isActive: widget.doctor.isActive,
      storeLocationId: widget.doctor.storeLocationId,
    );

    context.read<EditDoctorBloc>().add(UpdateDoctorEvent(updated));
  }

  void _deactivate() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Deactivate Doctor'),
        content: const Text(
          'This doctor will no longer be selectable for prescriptions.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<EditDoctorBloc>().add(
                    DeactivateDoctorEvent(widget.doctor.id!),
                  );
            },
            child: const Text('Deactivate'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditDoctorBloc, EditDoctorState>(
      listener: (context, state) {
        if (state is EditDoctorSuccess ||
            state is EditDoctorDeactivated) {
          Navigator.pop(context, true);
        }

        if (state is EditDoctorFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Doctor'),
          actions: [
            if (widget.doctor.isActive)
              IconButton(
                icon: const Icon(Icons.block),
                onPressed: _deactivate,
              ),
          ],
        ),
        floatingActionButton:
            BlocBuilder<EditDoctorBloc, EditDoctorState>(
          builder: (context, state) {
            final isLoading = state is EditDoctorSubmitting;

            return FloatingActionButton.extended(
              onPressed: isLoading ? null : _save,
              icon: isLoading
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.save),
              label: const Text('Save'),
            );
          },
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _field(_name, 'Name'),
              _field(_designation, 'Designation'),
              _field(_hospital, 'Hospital'),
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
