import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/features/staff/domain/entities/staff.dart';
import 'package:osm/features/staff/presentation/bloc/staff_bloc.dart';
import 'package:osm/features/staff/presentation/bloc/staff_event.dart';
import 'package:osm/features/staff/presentation/bloc/staff_state.dart';
import 'package:osm/features/store/presentation/bloc/store_location_bloc.dart';
import 'staff_form_screen.dart';

class ManageStaffScreen extends StatefulWidget {
  const ManageStaffScreen({super.key});

  @override
  State<ManageStaffScreen> createState() => _ManageStaffScreenState();
}

class _ManageStaffScreenState extends State<ManageStaffScreen> {

  @override
  void initState() {
    super.initState();

    final storeState = context.read<StoreLocationBloc>().state;

    if (storeState is StoreLocationLoaded && storeState.activeStore != null) {
      context.read<StaffBloc>().add(
        LoadStaff(storeId: storeState.activeStore!.id!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoreLocationBloc, StoreLocationState>(
      listener: (context, state) {
        if (state is StoreLocationLoaded && state.activeStore != null) {
          context.read<StaffBloc>().add(
            LoadStaff(storeId: state.activeStore!.id!),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Manage Staff'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.person_add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<StaffBloc>(),
                  child: const StaffFormScreen(),
                ),
              ),
            );
          },
        ),
        body: BlocBuilder<StaffBloc, StaffState>(
          builder: (context, state) {
            if (state is StaffLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is StaffLoaded) {
              if (state.staff.isEmpty) {
                return const Center(
                  child: Text('No staff added yet'),
                );
              }

              return ListView.separated(
                itemCount: state.staff.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final staff = state.staff[index];
                  return _StaffTile(staff: staff);
                },
              );
            }

            if (state is StaffError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _StaffTile extends StatelessWidget {
  final Staff staff;

  const _StaffTile({required this.staff});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(staff.name),
      subtitle: Text('${staff.role} • ${staff.phone}'),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          switch (value) {
            case 'edit':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<StaffBloc>(),
                    child: StaffFormScreen(staff: staff),
                  ),
                ),
              );
              break;

            case 'delete':
              _confirmDelete(context);
              break;
          }
        },
        itemBuilder: (_) => const [
          PopupMenuItem(
            value: 'edit',
            child: Text('Edit'),
          ),
          PopupMenuItem(
            value: 'delete',
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Staff'),
        content: const Text(
          'Are you sure you want to delete this staff member?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              context.read<StaffBloc>().add(
                    DeleteStaffEvent(staff.id!),
                  );
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}