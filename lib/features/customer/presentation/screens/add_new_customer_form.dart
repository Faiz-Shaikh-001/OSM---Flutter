// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:osm/features/customer/data/customer_model.dart';
// import 'package:osm/core/services/save_image_to_app_directory.dart';
// import 'package:osm/features/customer/viewmodel/customer_viewmodel.dart';
// import 'package:osm/core/widgets/build_text_field_widget.dart';
// import 'package:osm/core/widgets/custom_button.dart';
// import 'package:osm/core/widgets/image_selector_widget.dart';
// import 'package:provider/provider.dart';

// class AddNewCustomerForm extends StatefulWidget {
//   const AddNewCustomerForm({super.key});

//   @override
//   State<AddNewCustomerForm> createState() => _AddNewCustomerFormState();
// }

// class _AddNewCustomerFormState extends State<AddNewCustomerForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _secondaryPhoneController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _ageController = TextEditingController();
//   final _cityController = TextEditingController();
//   final _genderController = TextEditingController();
//   final List<File> _customerSelectedImages = [];
//   bool _isSaving = false;

//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _phoneController.dispose();
//     _secondaryPhoneController.dispose();
//     _emailController.dispose();
//     _ageController.dispose();
//     _cityController.dispose();
//     _genderController.dispose();
//     super.dispose();
//   }

//   Future<void> _saveCustomer() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     setState(() => _isSaving = true);

//     String profileImageUrl = 'https://placehold.co/100x100?text=Profile';
//     if (_customerSelectedImages.isNotEmpty) {
//       profileImageUrl = await saveImageToAppDirectory(
//         _customerSelectedImages.first,
//       );
//     }

//     final newCustomerData = CustomerModel(
//       firstName: _firstNameController.text,
//       lastName: _lastNameController.text,
//       city: _cityController.text,
//       primaryPhoneNumber: _phoneController.text,
//       secondaryPhoneNumber: _secondaryPhoneController.text,
//       email: _emailController.text,
//       gender: _genderController.text,
//       age: int.tryParse(_ageController.text) ?? 0,
//       profileImageUrl: profileImageUrl,
//     );

//     await context.read<CustomerViewModel>().addCustomer(newCustomerData);

//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('${newCustomerData.firstName} added successfully!'),
//         ),
//       );
//       // Pop the screen and return the newly created customer.
//       Navigator.of(context).pop(newCustomerData);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Add New Customer')),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               ImageSelectorWidget(
//                 selectedImages: _customerSelectedImages,
//                 onImagesChanged: (imgs) => setState(() {
//                   _customerSelectedImages
//                     ..clear()
//                     ..addAll(imgs);
//                 }),
//               ),
//               const SizedBox(height: 16),
//               BuildTextFieldWidget(
//                 controller: _firstNameController,
//                 label: 'First Name',
//               ),
//               BuildTextFieldWidget(
//                 controller: _lastNameController,
//                 label: 'Last Name',
//               ),
//               BuildTextFieldWidget(
//                 controller: _phoneController,
//                 label: 'Phone Number',
//               ),
//               BuildTextFieldWidget(
//                 controller: _secondaryPhoneController,
//                 label: 'Secondary Phone (Optional)',
//                 isOptional: true,
//               ),
//               BuildTextFieldWidget(
//                 controller: _emailController,
//                 label: 'Email (Optional)',
//                 isOptional: true,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: BuildTextFieldWidget(
//                       controller: _ageController,
//                       label: 'Age',
//                       isNumeric: true,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: BuildTextFieldWidget(
//                       controller: _genderController,
//                       label: 'Gender',
//                     ),
//                   ),
//                 ],
//               ),
//               BuildTextFieldWidget(controller: _cityController, label: 'City'),
//               const SizedBox(height: 32),
//               if (_isSaving)
//                 const Center(child: CircularProgressIndicator())
//               else
//                 CustomButton(onPressed: _saveCustomer, label: 'Save Customer'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:osm/core/widgets/image_selector.dart';
import 'package:osm/features/customer/data/customer_model.dart';
import 'package:osm/features/orders/viewmodel/order_viewmodel.dart';
import 'package:provider/provider.dart';

class AddNewCustomerForm extends StatefulWidget {
  const AddNewCustomerForm({super.key});

  @override
  State<AddNewCustomerForm> createState() => _AddNewCustomerFormState();
}

class _AddNewCustomerFormState extends State<AddNewCustomerForm> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _primaryPhoneCtrl = TextEditingController();
  final _secondaryPhoneCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();

  final List<File> _customerSelectedImages = [];
  String _gender = "Male";
  File? _pickedImage;

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final newCustomer = CustomerModel(
        firstName: _firstNameCtrl.text.trim(),
        lastName: _lastNameCtrl.text.trim(),
        city: _cityCtrl.text.trim(),
        primaryPhoneNumber: _primaryPhoneCtrl.text.trim(),
        secondaryPhoneNumber: _secondaryPhoneCtrl.text.trim(),
        gender: _gender,
        age: int.tryParse(_ageCtrl.text) ?? 0,
        profileImageUrl: _pickedImage?.path ?? "",
      );

      context.read<OrderViewModel>().selectCustomer(newCustomer);
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
