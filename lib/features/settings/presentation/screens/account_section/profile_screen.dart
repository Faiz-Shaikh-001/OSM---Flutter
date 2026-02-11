import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/account_bloc.dart';

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

  @override
  void initState() {
    super.initState();

    final state = context.read<AccountBloc>().state;
    if (state is AccountLoaded) {
      _nameController.text = state.account.name;
      _businessController.text = state.account.businessName;
      _emailController.text = state.account.email;
      _phoneController.text = state.account.phone;
      _addressController.text = state.account.address;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _businessController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    context.read<AccountBloc>().add(
          UpdateProfile(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            phone: _phoneController.text.trim(),
            businessName: _businessController.text.trim(),
            address: _addressController.text.trim(),
          ),
        );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View / Edit Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_outlined),
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: CircleAvatar(
              radius: 36,
              child: const Icon(Icons.person, size: 36),
            ),
          ),
          //TODO: Add profile picture upload functionality(bhutni ka nahi chal raha mere phone mein)
          const SizedBox(height: 24),

          _field('Your Name', _nameController),
          _field('Business Name', _businessController),
          _field('Email Address', _emailController),
          _field('Phone Number', _phoneController),
          _field('Address', _addressController, maxLines: 3),

          const SizedBox(height: 24),

          const Text(
            'Current Branch',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'No branch selected',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
