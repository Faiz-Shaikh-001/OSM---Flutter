import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/doctors/domain/entities/doctor.dart';
import 'package:osm/features/doctors/domain/repositories/doctor_repository.dart';
import 'package:osm/features/doctors/domain/usecases/add_doctor.dart';
import 'package:osm/features/doctors/presentation/blocs/add_doctor/add_doctor_bloc.dart';
import 'package:osm/features/doctors/presentation/blocs/doctor/doctor_bloc.dart';
import 'package:osm/features/doctors/presentation/screens/add_doctor_screen.dart';

class DoctorPickerBottomSheet extends StatefulWidget {
  final StoreLocationId storeLocationId;
  const DoctorPickerBottomSheet({super.key, required this.storeLocationId});

  @override
  State<DoctorPickerBottomSheet> createState() =>
      _DoctorPickerBottomSheetState();
}

class _DoctorPickerBottomSheetState extends State<DoctorPickerBottomSheet> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _searchField(),
            const SizedBox(height: 8),

            Expanded(
              child: BlocBuilder<DoctorBloc, DoctorState>(
                builder: (context, state) {
                  if (state is DoctorLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is DoctorLoaded) {
                    final filtered = _filterDoctors(state.doctors);

                    if (filtered.isEmpty) {
                      return _emptyResult(context, widget.storeLocationId);
                    }

                    return ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (_, i) {
                        final doctor = filtered[i];

                        return ListTile(
                          title: Text(doctor.name),
                          subtitle: Text(
                            '${doctor.designation} • ${doctor.hospital}',
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => Navigator.pop(context, doctor),
                        );
                      },
                    );
                  }

                  if (state is DoctorEmpty) {
                    return _emptyResult(context, widget.storeLocationId);
                  }

                  if (state is DoctorError) {
                    return Center(child: Text(state.message));
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchField() {
    return TextField(
      controller: _searchController,
      decoration: const InputDecoration(
        hintText: 'Search doctor (name, hospital, city)',
        prefixIcon: Icon(Icons.search),
      ),
      onChanged: (value) {
        setState(() => _query = value.trim().toLowerCase());
      },
    );
  }

  List<Doctor> _filterDoctors(List<Doctor> doctors) {
    return doctors.where((d) => d.isActive).where((d) {
      if (_query.isEmpty) return true;

      return d.name.toLowerCase().contains(_query) ||
          d.designation.toLowerCase().contains(_query) ||
          d.hospital.toLowerCase().contains(_query) ||
          d.city.toLowerCase().contains(_query);
    }).toList();
  }

  Widget _emptyResult(BuildContext context, StoreLocationId storeLocationId) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('No doctor found'),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Add Doctor'),
            onPressed: () async {
              final doctor = await Navigator.push<Doctor>(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (context) => AddDoctorBloc(
                      addDoctor: AddDoctor(context.read<DoctorRepository>()),
                    ),
                    child: AddDoctorScreen(storeLocationId: storeLocationId),
                  ),
                ),
              );

              if (doctor != null && context.mounted) {
                Navigator.pop(context, doctor);
              }
            },
          ),
        ],
      ),
    );
  }
}
