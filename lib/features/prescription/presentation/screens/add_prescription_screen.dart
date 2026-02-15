import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/doctors/domain/entities/doctor.dart';
import 'package:osm/features/doctors/domain/repositories/doctor_repository.dart';
import 'package:osm/features/doctors/domain/usecases/get_all_doctors.dart';
import 'package:osm/features/doctors/domain/usecases/get_doctors_by_store_location.dart';
import 'package:osm/features/doctors/presentation/blocs/doctor/doctor_bloc.dart';
import 'package:osm/features/doctors/presentation/widgets/doctor_picker_bottom_sheet.dart';
import 'package:osm/features/prescription/domain/entities/prescription.dart';
import 'package:osm/features/prescription/domain/entities/prescription_source.dart';
import 'package:osm/features/prescription/domain/value_objects/eye_power.dart';
import 'package:osm/features/prescription/domain/value_objects/pupillary_distance.dart';
import 'package:osm/features/prescription/presentation/bloc/add_prescription/add_prescription_bloc.dart';
import 'package:osm/features/store/presentation/bloc/store_location_bloc.dart';

class AddPrescriptionScreen extends StatefulWidget {
  final CustomerId customerId;

  const AddPrescriptionScreen({super.key, required this.customerId});

  @override
  State<AddPrescriptionScreen> createState() => _AddPrescriptionScreenState();
}

class _AddPrescriptionScreenState extends State<AddPrescriptionScreen> {
  final _formKey = GlobalKey<FormState>();

  // Meta
  PrescriptionSource _source = PrescriptionSource.internal;
  DateTime _prescriptionDate = DateTime.now();
  DoctorId? _doctorId;

  // Right eye
  final _rSphere = TextEditingController();
  final _rCylinder = TextEditingController();
  final _rAxis = TextEditingController();
  final _rAdd = TextEditingController();

  // Left eye
  final _lSphere = TextEditingController();
  final _lCylinder = TextEditingController();
  final _lAxis = TextEditingController();
  final _lAdd = TextEditingController();

  // PD
  final _pdLeft = TextEditingController();
  final _pdRight = TextEditingController();

  final _notes = TextEditingController();

  @override
  void dispose() {
    _rSphere.dispose();
    _rCylinder.dispose();
    _rAxis.dispose();
    _rAdd.dispose();
    _lSphere.dispose();
    _lCylinder.dispose();
    _lAxis.dispose();
    _lAdd.dispose();
    _pdLeft.dispose();
    _pdRight.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    try {
      final prescription = Prescription(
        createdAt: DateTime.now(),
        prescriptionDate: _prescriptionDate,
        source: _source,
        doctorId: _source == PrescriptionSource.external ? _doctorId : null,
        rightEye: EyePower(
          sphere: double.parse(_rSphere.text),
          cylinder: _rCylinder.text.isEmpty
              ? null
              : double.parse(_rCylinder.text),
          axis: _rAxis.text.isEmpty ? null : int.parse(_rAxis.text),
          add: _rAdd.text.isEmpty ? null : double.parse(_rAdd.text),
        ),
        leftEye: EyePower(
          sphere: double.parse(_lSphere.text),
          cylinder: _lCylinder.text.isEmpty
              ? null
              : double.parse(_lCylinder.text),
          axis: _lAxis.text.isEmpty ? null : int.parse(_lAxis.text),
          add: _lAdd.text.isEmpty ? null : double.parse(_lAdd.text),
        ),
        pd: _pdLeft.text.isEmpty || _pdRight.text.isEmpty
            ? null
            : PupillaryDistance(
                left: double.parse(_pdLeft.text),
                right: double.parse(_pdRight.text),
              ),
        notes: _notes.text.isEmpty ? null : _notes.text,
      );

      context.read<AddPrescriptionBloc>().add(
        SubmitPrescription(prescription, widget.customerId),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreLocationBloc, StoreLocationState>(
      builder: (context, storeState) {
        if (storeState is StoreLocationLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (storeState is StoreLocationError) {
          return Scaffold(body: Center(child: Text(storeState.message)));
        }

        if (storeState is! StoreLocationLoaded ||
            storeState.activeStore == null) {
          return const Scaffold(
            body: Center(child: Text('No active store available')),
          );
        }

        final storeLocationId = storeState.activeStore!.id;

        return BlocListener<AddPrescriptionBloc, AddPrescriptionState>(
          listener: (context, state) {
            if (state is AddPrescriptionSuccess) {
              Navigator.pop(context, state.prescription);
            }
            if (state is AddPrescriptionFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: Scaffold(
            appBar: AppBar(title: const Text('Add Prescription')),
            floatingActionButton:
                BlocBuilder<AddPrescriptionBloc, AddPrescriptionState>(
                  builder: (context, state) {
                    final isLoading = state is AddPrescriptionSubmitting;

                    return FloatingActionButton.extended(
                      onPressed: isLoading ? null : _submit,
                      icon: isLoading
                          ? const CircularProgressIndicator()
                          : const Icon(Icons.save),
                      label: const Text('Save'),
                    );
                  },
                ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _section(
                      title: 'Prescription Info',
                      children: [
                        DropdownButtonFormField<PrescriptionSource>(
                          initialValue: _source,
                          items: PrescriptionSource.values
                              .map(
                                (s) => DropdownMenuItem(
                                  value: s,
                                  child: Text(s.name.toUpperCase()),
                                ),
                              )
                              .toList(),
                          onChanged: (v) => setState(() => _source = v!),
                          decoration: const InputDecoration(
                            labelText: 'Source',
                          ),
                        ),
                        const SizedBox(height: 8),
                        ListTile(
                          title: Text(
                            'Date: ${_prescriptionDate.toLocal().toString().split(' ').first}',
                          ),
                          trailing: const Icon(Icons.calendar_today),
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                              initialDate: _prescriptionDate,
                            );
                            if (date != null) {
                              setState(() => _prescriptionDate = date);
                            }
                          },
                        ),
                      ],
                    ),

                    if (_source == PrescriptionSource.external)
                      _section(
                        title: 'Doctor',
                        children: [
                          ListTile(
                            title: Text(
                              _doctorId == null
                                  ? 'Select Doctor'
                                  : 'Doctor Selected',
                            ),
                            trailing: const Icon(Icons.person),
                            onTap: () async {
                              final doctor = await showModalBottomSheet<Doctor>(
                                context: context,
                                isScrollControlled: true,
                                builder: (_) => BlocProvider(
                                  create: (context) {
                                    final repo = context
                                        .read<DoctorRepository>();
                                    return DoctorBloc(
                                      getAllDoctor: GetAllDoctors(repo),
                                      getDoctorsByStoreLocation:
                                          GetDoctorsByStoreLocation(repo),
                                    )..add(LoadDoctors());
                                  },
                                  child: DoctorPickerBottomSheet(
                                    storeLocationId: storeLocationId!,
                                  ),
                                ),
                              );

                              if (doctor != null) {
                                setState(() {
                                  _doctorId = doctor.id;
                                });
                              }
                            },
                          ),
                        ],
                      ),

                    _eyeSection(
                      'Right Eye',
                      _rSphere,
                      _rCylinder,
                      _rAxis,
                      _rAdd,
                    ),
                    _eyeSection(
                      'Left Eye',
                      _lSphere,
                      _lCylinder,
                      _lAxis,
                      _lAdd,
                    ),

                    _section(
                      title: 'Pupillary Distance (Optional)',
                      children: [
                        _numberField(_pdLeft, 'Left PD'),
                        _numberField(_pdRight, 'Right PD'),
                      ],
                    ),

                    _section(
                      title: 'Notes',
                      children: [
                        TextFormField(
                          controller: _notes,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            hintText: 'Optional notes',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _eyeSection(
    String title,
    TextEditingController sphere,
    TextEditingController cyl,
    TextEditingController axis,
    TextEditingController add,
  ) {
    return _section(
      title: title,
      children: [
        _numberField(sphere, 'Sphere', required: true),
        _numberField(cyl, 'Cylinder'),
        _numberField(axis, 'Axis', isInt: true),
        _numberField(add, 'Add'),
      ],
    );
  }

  Widget _numberField(
    TextEditingController c,
    String label, {
    bool required = false,
    bool isInt = false,
  }) {
    return TextFormField(
      controller: c,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      validator: (v) {
        if (required && (v == null || v.isEmpty)) {
          return 'Required';
        }
        if (v != null && v.isNotEmpty) {
          return isInt
              ? int.tryParse(v) == null
                    ? 'Invalid number'
                    : null
              : double.tryParse(v) == null
              ? 'Invalid number'
              : null;
        }
        return null;
      },
    );
  }

  Widget _section({required String title, required List<Widget> children}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }
}
