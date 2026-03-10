import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/features/staff/domain/entities/staff.dart';
import 'package:osm/features/staff/presentation/bloc/staff_bloc.dart';
import 'package:osm/features/staff/presentation/bloc/staff_event.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/store/presentation/bloc/store_location_bloc.dart';

class StaffFormScreen extends StatefulWidget {
  final Staff? staff;

  const StaffFormScreen({super.key, this.staff});

  @override
  State<StaffFormScreen> createState() => _StaffFormScreenState();
}

class _StaffFormScreenState extends State<StaffFormScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  String _role = 'Staff';

  bool _initialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _save(BuildContext context) {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name and phone are required')),
      );
      return;
    }

    /// 🔹 Get active store from StoreLocationBloc
    final storeState = context.read<StoreLocationBloc>().state;

    if (storeState is! StoreLocationLoaded || storeState.activeStore == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No active store selected')),
      );
      return;
    }

    final storeId = storeState.activeStore!.id!;

    if (widget.staff == null) {
      final staff = Staff(
        name: name,
        phone: phone,
        email: email,
        role: _role,
        storeId: storeId,
        isActive: true,
        createdAt: DateTime.now(),
      );

      context.read<StaffBloc>().add(AddStaffEvent(staff));
    } else {
      final updated = widget.staff!.copyWith(
        name: name,
        phone: phone,
        email: email,
        role: _role,
      );

      context.read<StaffBloc>().add(UpdateStaffEvent(updated));
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized && widget.staff != null) {
      final staff = widget.staff!;

      _nameController.text = staff.name;
      _phoneController.text = staff.phone;
      _emailController.text = staff.email;
      _role = staff.role;

      _initialized = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.staff == null ? 'Add Staff' : 'Edit Staff'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_outlined),
            onPressed: () => _save(context),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _field('Name', _nameController),
          _field(
            'Phone',
            _phoneController,
            keyboardType: TextInputType.phone,
          ),
          _field(
            'Email',
            _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          const Text(
            'Role',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _role,
            items: const [
              DropdownMenuItem(
                value: 'Owner',
                child: Text('Owner'),
              ),
              DropdownMenuItem(
                value: 'Manager',
                child: Text('Manager'),
              ),
              DropdownMenuItem(
                value: 'Staff',
                child: Text('Staff'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _role = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}