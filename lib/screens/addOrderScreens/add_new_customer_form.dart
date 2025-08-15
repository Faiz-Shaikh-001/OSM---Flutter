// file: add_new_customer_form.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:osm/data/models/customer_model.dart';
import 'package:osm/services/save_image_to_app_directory.dart';
import 'package:osm/viewmodels/customer_viewmodel.dart';
import 'package:osm/widgets/build_text_field_widget.dart';
import 'package:osm/widgets/custom_button.dart';
import 'package:osm/widgets/image_selector_widget.dart';
import 'package:provider/provider.dart';

class AddNewCustomerForm extends StatefulWidget {
  const AddNewCustomerForm({super.key});

  @override
  State<AddNewCustomerForm> createState() => _AddNewCustomerFormState();
}

class _AddNewCustomerFormState extends State<AddNewCustomerForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _secondaryPhoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final _cityController = TextEditingController();
  final _genderController = TextEditingController();
  final List<File> _customerSelectedImages = [];
  bool _isSaving = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _secondaryPhoneController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _cityController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  Future<void> _saveCustomer() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSaving = true);

    String profileImageUrl = 'https://placehold.co/100x100?text=Profile';
    if (_customerSelectedImages.isNotEmpty) {
      profileImageUrl = await saveImageToAppDirectory(
        _customerSelectedImages.first,
      );
    }

    final newCustomerData = CustomerModel(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      city: _cityController.text,
      primaryPhoneNumber: _phoneController.text,
      secondaryPhoneNumber: _secondaryPhoneController.text,
      email: _emailController.text,
      gender: _genderController.text,
      age: int.tryParse(_ageController.text) ?? 0,
      profileImageUrl: profileImageUrl,
    );

    await context.read<CustomerViewModel>().addCustomer(newCustomerData);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${newCustomerData.firstName} added successfully!'),
        ),
      );
      // Pop the screen and return the newly created customer.
      Navigator.of(context).pop(newCustomerData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Customer')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              BuildTextFieldWidget(
                controller: _firstNameController,
                label: 'First Name',
              ),
              BuildTextFieldWidget(
                controller: _lastNameController,
                label: 'Last Name',
              ),
              BuildTextFieldWidget(
                controller: _phoneController,
                label: 'Phone Number',
              ),
              BuildTextFieldWidget(
                controller: _secondaryPhoneController,
                label: 'Secondary Phone (Optional)',
                isOptional: true,
              ),
              BuildTextFieldWidget(
                controller: _emailController,
                label: 'Email (Optional)',
                isOptional: true,
              ),
              Row(
                children: [
                  Expanded(
                    child: BuildTextFieldWidget(
                      controller: _ageController,
                      label: 'Age',
                      isNumeric: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: BuildTextFieldWidget(
                      controller: _genderController,
                      label: 'Gender',
                    ),
                  ),
                ],
              ),
              BuildTextFieldWidget(controller: _cityController, label: 'City'),
              const SizedBox(height: 32),
              if (_isSaving)
                const Center(child: CircularProgressIndicator())
              else
                CustomButton(onPressed: _saveCustomer, label: 'Save Customer'),
            ],
          ),
        ),
      ),
    );
  }
}
