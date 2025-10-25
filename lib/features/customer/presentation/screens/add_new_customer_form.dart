import 'dart:io';
import 'package:flutter/material.dart';
import 'package:osm/core/services/save_image_to_app_directory.dart';
import 'package:osm/core/widgets/image_selector.dart';
import 'package:osm/features/customer/data/customer_model.dart';
import 'package:osm/features/customer/viewmodel/customer_viewmodel.dart';
import 'package:osm/features/orders/viewmodel/order_viewmodel.dart';
import 'package:provider/provider.dart';

class AddNewCustomerForm extends StatefulWidget {
  final bool fromCustomerStep;
  const AddNewCustomerForm({super.key, this.fromCustomerStep = false});

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

  bool _isSaving = false;

  final List<File> _customerSelectedImages = [];
  String _gender = "Male";

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _primaryPhoneCtrl.dispose();
    _secondaryPhoneCtrl.dispose();
    _emailCtrl.dispose();
    _ageCtrl.dispose();
    _cityCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    String profileImageUrl =
        'https://placehold.co/100x100?text=${_firstNameCtrl.text}';

    if (_customerSelectedImages.isNotEmpty) {
      profileImageUrl = await saveImageToAppDirectory(
        _customerSelectedImages.first,
      );
    }

    final newCustomer = CustomerModel(
      firstName: _firstNameCtrl.text.trim(),
      lastName: _lastNameCtrl.text.trim(),
      city: _cityCtrl.text.trim(),
      primaryPhoneNumber: _primaryPhoneCtrl.text.trim(),
      secondaryPhoneNumber: _secondaryPhoneCtrl.text.trim(),
      gender: _gender,
      email: _emailCtrl.text,
      age: int.tryParse(_ageCtrl.text) ?? 0,
      profileImageUrl: profileImageUrl,
    );

    if (widget.fromCustomerStep) {
      await context.read<CustomerViewModel>().addCustomer(newCustomer);
      context.read<OrderViewModel>().selectCustomer(newCustomer);
      setState(() {
        _isSaving = false;
      });
      Navigator.pop(context, newCustomer);
    } else {
      await context.read<CustomerViewModel>().addCustomer(newCustomer);
      setState(() {
        _isSaving = false;
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ImageSelectorWidget(
                selectedImages: _customerSelectedImages,
                onImagesChanged: (imgs) => setState(() {
                  _customerSelectedImages
                    ..clear()
                    ..addAll(imgs);
                }),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _firstNameCtrl,
                decoration: const InputDecoration(labelText: "First Name"),
                validator: (val) =>
                    val == null || val.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: _lastNameCtrl,
                decoration: const InputDecoration(labelText: "Last Name"),
              ),
              TextFormField(
                controller: _primaryPhoneCtrl,
                decoration: const InputDecoration(labelText: "Phone Number"),
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
              TextFormField(
                controller: _cityCtrl,
                decoration: const InputDecoration(labelText: "City"),
              ),
              TextFormField(
                controller: _ageCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Age"),
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _gender,
                items: const [
                  DropdownMenuItem(value: "Male", child: Text("Male")),
                  DropdownMenuItem(value: "Female", child: Text("Female")),
                ],
                onChanged: (val) => setState(() => _gender = val ?? "Male"),
              ),

              const SizedBox(height: 20),
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
                      onPressed: _saveForm,
                      child: const Text("Save"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
