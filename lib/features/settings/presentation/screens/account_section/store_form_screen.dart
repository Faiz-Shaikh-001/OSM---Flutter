import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/store/domain/entities/store_location.dart';
import 'package:osm/features/store/presentation/bloc/store_location_bloc.dart';

class StoreFormScreen extends StatefulWidget {
  final StoreLocation? store; // null = Add, non-null = Edit

  const StoreFormScreen({super.key, this.store});

  @override
  State<StoreFormScreen> createState() => _StoreFormScreenState();
}

class _StoreFormScreenState extends State<StoreFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController name;
  late final TextEditingController address;
  late final TextEditingController city;
  late final TextEditingController state;
  late final TextEditingController postalCode;
  late final TextEditingController country;
  late final TextEditingController phone;
  late final TextEditingController license;
  late final TextEditingController hours;

  @override
  void initState() {
    super.initState();

    final s = widget.store;

    name = TextEditingController(text: s?.name ?? '');
    address = TextEditingController(text: s?.address ?? '');
    city = TextEditingController(text: s?.city ?? '');
    state = TextEditingController(text: s?.state ?? '');
    postalCode = TextEditingController(text: s?.postalCode ?? '');
    country = TextEditingController(text: s?.country ?? 'India');
    phone = TextEditingController(text: s?.phoneNumber ?? '');
    license = TextEditingController(text: s?.licenseNumber ?? '');
    hours = TextEditingController(text: s?.operatingHours ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.store != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Store' : 'Add Store'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _field(name, 'Store Name'),
            _field(address, 'Address'),
            _field(city, 'City'),
            _field(state, 'State'),
            _field(postalCode, 'Postal Code'),
            _field(country, 'Country'),
            _field(phone, 'Phone Number'),
            _field(license, 'License Number'),
            _field(hours, 'Operating Hours'),

            const SizedBox(height: 24),

            FilledButton(
              onPressed: _submit,
              child: Text(isEdit ? 'Update Store' : 'Add Store'),
            ),
          ],
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
        validator: (v) => v == null || v.isEmpty ? 'Required' : null,
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final store = StoreLocation(
      id: widget.store?.id,
      name: name.text.trim(),
      address: address.text.trim(),
      city: city.text.trim(),
      state: state.text.trim(),
      postalCode: postalCode.text.trim(),
      country: country.text.trim(),
      phoneNumber: phone.text.trim(),
      operatingHours: hours.text.trim(),
      licenseNumber: license.text.trim(),
      isActive: false,
      createdAt: widget.store?.createdAt ?? DateTime.now(),
      storeLogoUrl: widget.store?.storeLogoUrl,
    );

    final bloc = context.read<StoreLocationBloc>();

    if (widget.store == null) {
      bloc.add(AddStoreLocationEvent(store));
    } else {
      bloc.add(UpdateStoreLocationEvent(store));
    }

    Navigator.pop(context);
  }
}