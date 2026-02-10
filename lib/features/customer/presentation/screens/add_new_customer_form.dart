// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:osm/core/services/save_image_to_app_directory.dart';
import 'package:osm/core/widgets/image_selector.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/customer/domain/entities/customer_type.dart';
import 'package:osm/features/customer/presentation/utils/customer_type_ui.dart';

class AddNewCustomerForm extends StatefulWidget {
  final Customer? initialCustomer;
  const AddNewCustomerForm({
    super.key,
    this.initialCustomer,
  });

  @override
  State<AddNewCustomerForm> createState() => _AddNewCustomerFormState();
}

class _AddNewCustomerFormState extends State<AddNewCustomerForm> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _primaryPhoneCtrl = TextEditingController();
  final _secondaryPhoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  final _streetCtrl = TextEditingController();
  final _stateCtrl = TextEditingController();
  final _postalCodeCtrl = TextEditingController();
  final _countryCtrl = TextEditingController();

  DateTime? _dateOfBirth;
  final _notesCtrl = TextEditingController();
  final List<String> _tags = [];

  final List<File> _selectedImages = [];
  Gender _gender = Gender.male;
  CustomerType _customerType = CustomerType.walkIn;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final c = widget.initialCustomer;
    if (c != null) {
      _firstNameCtrl.text = c.firstName;
      _lastNameCtrl.text = c.lastName;
      _primaryPhoneCtrl.text = c.primaryPhoneNumber;
      _secondaryPhoneCtrl.text = c.secondaryPhoneNumber ?? '';
      _emailCtrl.text = c.email ?? '';
      _streetCtrl.text = c.streetAddress ?? '';
      _cityCtrl.text = c.city ?? '';
      _stateCtrl.text = c.state ?? '';
      _postalCodeCtrl.text = c.postalCode ?? '';
      _countryCtrl.text = c.country ?? '';
      _gender = c.gender;
      _customerType = c.customerType;
      _dateOfBirth = c.dateOfBirth;
      _notesCtrl.text = c.notes ?? '';
      _tags.addAll(c.tags);
    }
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _primaryPhoneCtrl.dispose();
    _secondaryPhoneCtrl.dispose();
    _emailCtrl.dispose();
    _ageCtrl.dispose();
    _streetCtrl.dispose();
    _cityCtrl.dispose();
    _stateCtrl.dispose();
    _postalCodeCtrl.dispose();
    _countryCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    String? profileImageUrl = widget.initialCustomer?.profileImageUrl;

    if (_selectedImages.isNotEmpty) {
      profileImageUrl = await saveImageToAppDirectory(_selectedImages.first);
    }

    final isEdit = widget.initialCustomer != null;
    final existing = widget.initialCustomer;

    final customer = Customer(
      id: isEdit ? existing!.id : null,
      firstName: _firstNameCtrl.text.trim(),
      lastName: _lastNameCtrl.text.trim(),
      primaryPhoneNumber: _primaryPhoneCtrl.text.trim(),
      secondaryPhoneNumber: _secondaryPhoneCtrl.text.trim().isEmpty
          ? null
          : _secondaryPhoneCtrl.text.trim(),
      email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
      gender: _gender,
      customerType: _customerType,
      dateOfBirth: _dateOfBirth,
      tags: _tags,
      notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
      streetAddress: _streetCtrl.text.trim().isEmpty
          ? null
          : _streetCtrl.text.trim(),
      city: _cityCtrl.text.trim().isEmpty ? null : _cityCtrl.text.trim(),
      state: _stateCtrl.text.trim().isEmpty ? null : _stateCtrl.text.trim(),
      postalCode: _postalCodeCtrl.text.trim().isEmpty
          ? null
          : _postalCodeCtrl.text.trim(),
      country: _countryCtrl.text.trim().isEmpty
          ? null
          : _countryCtrl.text.trim(),

      profileImageUrl: profileImageUrl,
      createdAt: isEdit ? existing!.createdAt : DateTime.now(),
    );

    setState(() => _isSaving = false);
    
    Navigator.pop(context, customer);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    ImageSelectorWidget(
                      selectedImages: _selectedImages,
                      onImagesChanged: (imgs) => setState(() {
                        _selectedImages
                          ..clear()
                          ..addAll(imgs);
                      }),
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _firstNameCtrl,
                      decoration: const InputDecoration(
                        labelText: "First Name",
                      ),
                      validator: (val) =>
                          val == null || val.isEmpty ? "Required" : null,
                    ),
                    TextFormField(
                      controller: _lastNameCtrl,
                      decoration: const InputDecoration(labelText: "Last Name"),
                    ),
                    TextFormField(
                      controller: _primaryPhoneCtrl,
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                      ),
                      validator: (val) =>
                          val == null || val.isEmpty ? "Required" : null,
                    ),
                    TextFormField(
                      controller: _secondaryPhoneCtrl,
                      decoration: const InputDecoration(
                        labelText: "Secondary Phone Number (Optional)",
                      ),
                    ),
                    TextFormField(
                      controller: _emailCtrl,
                      decoration: const InputDecoration(labelText: "Email"),
                    ),

                    const SizedBox(height: 16),

                    ListTile(
                      title: const Text('Date of Birth'),
                      subtitle: Text(
                        _dateOfBirth == null
                            ? 'Not set'
                            : _dateOfBirth!
                                  .toLocal()
                                  .toString()
                                  .split(' ')
                                  .first,
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _dateOfBirth ?? DateTime(2000),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                        if (picked != null) {
                          setState(() => _dateOfBirth = picked);
                        }
                      },
                    ),

                    DropdownButtonFormField<Gender>(
                      initialValue: _gender,
                      items: Gender.values.map((g) {
                        return DropdownMenuItem(
                          value: g,
                          child: Text(g.name.capitalize),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _gender = val!),
                    ),

                    DropdownButtonFormField<CustomerType>(
                      initialValue: _customerType,
                      decoration: const InputDecoration(
                        labelText: 'Customer Type',
                      ),
                      items: CustomerType.values.map((type) {
                        return DropdownMenuItem<CustomerType>(
                          value: type,
                          child: Text(type.label),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _customerType = value);
                        }
                      },
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Address (Optional)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextFormField(
                      controller: _streetCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Street Address',
                      ),
                      maxLines: 2,
                    ),

                    TextFormField(
                      controller: _cityCtrl,
                      decoration: const InputDecoration(labelText: 'City'),
                    ),

                    TextFormField(
                      controller: _stateCtrl,
                      decoration: const InputDecoration(labelText: 'State'),
                    ),

                    TextFormField(
                      controller: _postalCodeCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Postal Code',
                      ),
                      keyboardType: TextInputType.number,
                    ),

                    TextFormField(
                      controller: _countryCtrl,
                      decoration: const InputDecoration(labelText: 'Country'),
                    ),

                    const SizedBox(height: 16),

                    Wrap(
                      spacing: 8,
                      children: [
                        ..._tags.map(
                          (t) => Chip(
                            label: Text(t),
                            onDeleted: () => setState(() => _tags.remove(t)),
                          ),
                        ),
                        ActionChip(
                          label: const Text('Add Tag'),
                          onPressed: () async {
                            final tag = await showDialog<String>(
                              context: context,
                              builder: (_) {
                                final ctrl = TextEditingController();
                                return AlertDialog(
                                  title: const Text('Add tag'),
                                  content: TextField(controller: ctrl),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => Navigator.pop(
                                        context,
                                        ctrl.text.trim(),
                                      ),
                                      child: const Text('Add'),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (tag != null && tag.isNotEmpty) {
                              setState(() => _tags.add(tag));
                            }
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _notesCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Notes',
                        alignLabelWithHint: true,
                      ),
                      maxLines: 4,
                    ),

                    const SizedBox(height: 24),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _isSaving ? null : _submit,
                            child: const Text("Save"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
