import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/features/settings/profile/models/profile_model.dart';

class ChangeCredentialsScreen extends StatefulWidget {
  const ChangeCredentialsScreen({super.key});

  @override
  State<ChangeCredentialsScreen> createState() => _ChangeCredentialsScreenState();
}

class _ChangeCredentialsScreenState extends State<ChangeCredentialsScreen> {
  final IsarService isarService = IsarService();
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  UserProfile _userProfile = UserProfile();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    final isar = await isarService.db;
    UserProfile? profile = await isar.userProfiles.get(1);
    if (mounted) {
      setState(() {
        _userProfile = profile ?? UserProfile();
        _emailController.text = _userProfile.email ?? '';
        _phoneController.text = _userProfile.phone ?? '';
        _isLoading = false;
      });
    }
  }

  Future<void> _saveCredentials() async {
    // First, validate the form input
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // TODO: Implement real password verification here.
    // For now, we'll just check if the password field is not empty.
    if (_passwordController.text.isEmpty) {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your current password to save changes.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final isar = await isarService.db;

    // Update the profile object with the new data
    _userProfile.email = _emailController.text;
    _userProfile.phone = _phoneController.text;

    // Write the changes to the database
    await isar.writeTxn(() async {
      await isar.userProfiles.put(_userProfile);
    });
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credentials updated successfully!')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Email / Phone'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_outlined),
            onPressed: _saveCredentials,
            tooltip: 'Save Changes',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'New Email Address',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value != null && value.isNotEmpty && (!value.contains('@') || !value.contains('.'))) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'New Phone Number',
                        prefixIcon: Icon(Icons.phone_outlined),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),
                    Text(
                      'For your security, please confirm your password to save changes.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Current Password',
                        prefixIcon: Icon(Icons.lock_outline),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required to save changes.';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
