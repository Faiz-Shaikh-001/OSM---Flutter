import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/store/domain/entities/store_location.dart';
import 'package:osm/features/store/presentation/bloc/store_location_bloc.dart';
//import 'package:osm/features/store/presentation/bloc/store_location_event.dart';

class AddEditStoreScreen extends StatefulWidget {
  final StoreLocation? store;

  const AddEditStoreScreen({super.key, this.store});

  @override
  State<AddEditStoreScreen> createState() => _AddEditStoreScreenState();
}

class _AddEditStoreScreenState extends State<AddEditStoreScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _name;
  late final TextEditingController _address;
  late final TextEditingController _city;
  late final TextEditingController _state;
  late final TextEditingController _postalCode;
  late final TextEditingController _country;
  late final TextEditingController _phone;
  late final TextEditingController _license;
  late final TextEditingController _hours;

  bool get isEdit => widget.store != null;

  @override
  void initState() {
    super.initState();
    final s = widget.store;

    _name = TextEditingController(text: s?.name ?? '');
    _address = TextEditingController(text: s?.address ?? '');
    _city = TextEditingController(text: s?.city ?? '');
    _state = TextEditingController(text: s?.state ?? '');
    _postalCode = TextEditingController(text: s?.postalCode ?? '');
    _country = TextEditingController(text: s?.country ?? 'India');
    _phone = TextEditingController(text: s?.phoneNumber ?? '');
    _license = TextEditingController(text: s?.licenseNumber ?? '');
    _hours = TextEditingController(text: s?.operatingHours ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    _address.dispose();
    _city.dispose();
    _state.dispose();
    _postalCode.dispose();
    _country.dispose();
    _phone.dispose();
    _license.dispose();
    _hours.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final store = StoreLocation(
      id: widget.store?.id,
      name: _name.text.trim(),
      address: _address.text.trim(),
      city: _city.text.trim(),
      state: _state.text.trim(),
      postalCode: _postalCode.text.trim(),
      country: _country.text.trim(),
      phoneNumber: _phone.text.trim(),
      operatingHours: _hours.text.trim(),
      licenseNumber: _license.text.trim(),
      isActive: widget.store?.isActive ?? false,
      createdAt: widget.store?.createdAt ?? DateTime.now(),
      storeLogoUrl: widget.store?.storeLogoUrl,
    );

    final bloc = context.read<StoreLocationBloc>();

    if (isEdit) {
      bloc.add(UpdateStoreLocationEvent(store));
    } else {
      bloc.add(AddStoreLocationEvent(store));
    }

    Navigator.pop(context);
  }

  void _delete() {
    if (!isEdit || widget.store?.id == null) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Store'),
        content: const Text(
          'This action is permanent and cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              context.read<StoreLocationBloc>().add(
                    DeleteStoreLocationEvent(widget.store!.id!),
                  );
              Navigator.pop(context); // dialog
              Navigator.pop(context); // screen
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Store' : 'Add Store'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_outlined),
            onPressed: _save,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _field(_name, 'Store Name'),
            _field(_address, 'Address'),
            _field(_city, 'City'),
            _field(_state, 'State'),
            _field(_postalCode, 'Postal Code'),
            _field(_country, 'Country'),
            _field(_phone, 'Phone Number'),
            _field(_license, 'License Number'),
            _field(_hours, 'Operating Hours'),

            if (isEdit) ...[
              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade50,
                  foregroundColor: Colors.red,
                ),
                icon: const Icon(Icons.delete_forever),
                label: const Text('Delete Store'),
                onPressed: _delete,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _field(TextEditingController c, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: c,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (v) =>
            v == null || v.trim().isEmpty ? 'Required' : null,
      ),
    );
  }
}