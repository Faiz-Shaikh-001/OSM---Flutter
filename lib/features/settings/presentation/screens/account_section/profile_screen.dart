import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/account_bloc.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _businessController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  bool _initialized = false;
  String? _profileImagePath;

  @override
  void dispose() {
    _nameController.dispose();
    _businessController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _saveProfile(BuildContext context) {
    context.read<AccountBloc>().add(
          UpdateProfile(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            phone: _phoneController.text.trim(),
            businessName: _businessController.text.trim(),
            address: _addressController.text.trim(),
            profileImagePath: _profileImagePath,
          ),
        );

    Navigator.pop(context);
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return;

    setState(() {
      _profileImagePath = picked.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View / Edit Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_outlined),
            onPressed: () => _saveProfile(context),
          ),
        ],
      ),
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is! AccountLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          // Initialize controllers only once
          if (!_initialized) {
            final account = state.account;

            _nameController.text = account.name;
            _businessController.text = account.businessName;
            _emailController.text = account.email;
            _phoneController.text = account.phone;
            _addressController.text = account.address;

            _profileImagePath = account.profileImagePath;

            _initialized = true;
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: _profileImagePath != null
                        ? FileImage(File(_profileImagePath!))
                        : null,
                    child: _profileImagePath == null
                        ? const Icon(Icons.person, size: 40)
                        : null,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              _field('Your Name', _nameController),
              _field('Business Name', _businessController),

              _field(
                'Email Address',
                _emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              _field(
                'Phone Number',
                _phoneController,
                keyboardType: TextInputType.phone,
              ),

              _field('Address', _addressController, maxLines: 3),

              const SizedBox(height: 24),

              const Text(
                'Current Branch',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 4),

              const Text(
                'Linked to active store',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}