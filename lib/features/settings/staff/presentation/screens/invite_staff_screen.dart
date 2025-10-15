import 'package:flutter/material.dart';
import '../../models/staff_model.dart';

class InviteStaffScreen extends StatefulWidget {
  // We can now optionally pass a staff member to edit
  final Staff? staffToEdit;

  const InviteStaffScreen({
    super.key,
    this.staffToEdit,
  });

  @override
  State<InviteStaffScreen> createState() => _InviteStaffScreenState();
}

class _InviteStaffScreenState extends State<InviteStaffScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  StaffRole _selectedRole = StaffRole.cashier;

  // A helper to easily check if we are in "edit mode"
  bool get _isEditing => widget.staffToEdit != null;

  @override
  void initState() {
    super.initState();
    // If we are editing, pre-fill the form fields with the existing data
    if (_isEditing) {
      _nameController.text = widget.staffToEdit!.name;
      _emailController.text = widget.staffToEdit!.email;
      _selectedRole = widget.staffToEdit!.role;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final staffData = Staff()
        ..name = _nameController.text
        ..email = _emailController.text
        ..role = _selectedRole;

      // If we are editing, we MUST preserve the original database ID
      if (_isEditing) {
        staffData.id = widget.staffToEdit!.id;
      }

      // Return the saved/updated staff object
      Navigator.of(context).pop(staffData);
    }
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Are you sure?'),
        content: Text('Do you want to permanently delete "${widget.staffToEdit!.name}"?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          FilledButton.tonal(
            style: FilledButton.styleFrom(backgroundColor: Colors.red.shade100),
            child: const Text('DELETE', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.of(ctx).pop(); // Close the dialog
              // Return 'true' to signal that deletion was confirmed
              Navigator.of(context).pop(true); 
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The title changes depending on the mode
        title: Text(_isEditing ? 'Edit Staff Member' : 'Invite New Staff'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_outlined),
            onPressed: _saveForm,
            tooltip: 'Save',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // The form fields remain the same
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Staff Name', prefixIcon: Icon(Icons.person_outline), border: OutlineInputBorder()),
                validator: (value) => value == null || value.trim().isEmpty ? 'Please enter a name.' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email Address', prefixIcon: Icon(Icons.email_outlined), border: OutlineInputBorder()),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Please enter an email.';
                  if (!value.contains('@') || !value.contains('.')) return 'Please enter a valid email address.';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<StaffRole>(
                value: _selectedRole,
                decoration: const InputDecoration(labelText: 'Assign Role', prefixIcon: Icon(Icons.security_outlined), border: OutlineInputBorder()),
                items: StaffRole.values.map((role) {
                  final roleName = role.name[0].toUpperCase() + role.name.substring(1);
                  return DropdownMenuItem(value: role, child: Text(roleName));
                }).toList(),
                onChanged: (newValue) {
                  if (newValue != null) setState(() => _selectedRole = newValue);
                },
              ),
              // --- The Delete button only shows up in edit mode ---
              if (_isEditing) ...[
                const SizedBox(height: 40),
                const Divider(),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.delete_forever_outlined),
                  label: const Text('Delete Staff Member'),
                  onPressed: _confirmDelete,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.red,
                    backgroundColor: Colors.red.shade50,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}

