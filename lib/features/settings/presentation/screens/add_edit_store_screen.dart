import 'package:flutter/material.dart';
// Corrected import path for the store model
import '../../../orders/data/models/store_model.dart';

class AddEditStoreScreen extends StatefulWidget {
  final Store? storeToEdit;

  const AddEditStoreScreen({
    super.key,
    this.storeToEdit,
  });

  @override
  State<AddEditStoreScreen> createState() => _AddEditStoreScreenState();
}

class _AddEditStoreScreenState extends State<AddEditStoreScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _phoneController = TextEditingController();

  bool get _isEditing => widget.storeToEdit != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _nameController.text = widget.storeToEdit!.name;
      _addressController.text = widget.storeToEdit!.address;
      _cityController.text = widget.storeToEdit!.city;
      _phoneController.text = widget.storeToEdit!.phone;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      // --- CHANGE IS HERE ---
      // We now use the constructor you created.
      final storeData = Store(
        name: _nameController.text,
        address: _addressController.text,
        city: _cityController.text,
        phone: _phoneController.text,
      );

      // If we are editing, we must preserve the original ID.
      if (_isEditing) {
        storeData.id = widget.storeToEdit!.id;
      }

      Navigator.of(context).pop(storeData);
    }
  }

  // --- Delete Functionality ---
  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: Text('Do you want to permanently delete "${widget.storeToEdit!.name}"? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(ctx).pop(); // Dismiss the dialog
              },
            ),
            FilledButton.tonal(
              style: FilledButton.styleFrom(backgroundColor: Colors.red.shade100),
              child: const Text('DELETE', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(ctx).pop(); // Dismiss the dialog
                Navigator.of(context).pop(true); 
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Store' : 'Add New Store'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_outlined),
            onPressed: _saveForm,
            tooltip: 'Save Store',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Store Name',
                  hintText: 'e.g., Main Street Branch',
                  prefixIcon: Icon(Icons.storefront_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a store name.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Store Address',
                  prefixIcon: Icon(Icons.location_on_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City / Town',
                  prefixIcon: Icon(Icons.location_city_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Contact Number',
                  prefixIcon: Icon(Icons.phone_outlined),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),

              // --- Delete Button ---
              if (_isEditing) ...[
                const SizedBox(height: 40),
                const Divider(),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.delete_forever_outlined),
                  label: const Text('Delete Store'),
                  onPressed: _confirmDelete,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.red,
                    backgroundColor: Colors.red.shade50,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

