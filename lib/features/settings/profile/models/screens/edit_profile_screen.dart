import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isar/isar.dart';

// Corrected relative paths based on new structure
import '../../../../../../core/services/isar_service.dart';
import '../profile_model.dart'; 
import '../../../../orders/data/models/store_model.dart';
import '../../../presentation/screens/select_store_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final IsarService isarService = IsarService();
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  
  UserProfile _userProfile = UserProfile();
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _businessNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    try {
      final isar = await isarService.db;
      UserProfile? profile = await isar.userProfiles.get(1);
      await profile?.currentBranch.load();

      if (mounted) {
        setState(() {
          _userProfile = profile ?? UserProfile();
          
          _nameController.text = _userProfile.name ?? '';
          _businessNameController.text = _userProfile.businessName ?? '';
          _emailController.text = _userProfile.email ?? '';
          _phoneController.text = _userProfile.phone ?? '';
          _addressController.text = _userProfile.address ?? '';
          
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = "Failed to load profile: $e";
        });
      }
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final isar = await isarService.db;

      _userProfile.name = _nameController.text;
      _userProfile.businessName = _businessNameController.text;
      _userProfile.email = _emailController.text;
      _userProfile.phone = _phoneController.text;
      _userProfile.address = _addressController.text;
      
      await isar.writeTxn(() async {
        // --- FIX: Save the profile FIRST to ensure it is managed by Isar ---
        await isar.userProfiles.put(_userProfile);
        // --- Then save the link ---
        await _userProfile.currentBranch.save();
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile saved successfully!')),
        );
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> _selectProfilePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null && mounted) {
      setState(() {
        _userProfile.profilePhotoPath = image.path;
      });
    }
  }

  void _changeBranch() async {
    final selectedStore = await Navigator.of(context).push<Store>(
      MaterialPageRoute(builder: (context) => const SelectStoreScreen()),
    );
    if (selectedStore != null && mounted) {
      setState(() {
        _userProfile.currentBranch.value = selectedStore;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View/Edit Profile'),
        actions: [
          if (!_isLoading && _errorMessage == null)
            IconButton(
              icon: const Icon(Icons.save_outlined),
              onPressed: _saveProfile,
              tooltip: 'Save Profile',
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_errorMessage != null) {
      return Center(child: Text(_errorMessage!));
    }

    final hasProfilePhoto = _userProfile.profilePhotoPath != null && _userProfile.profilePhotoPath!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: hasProfilePhoto ? FileImage(File(_userProfile.profilePhotoPath!)) : null,
                    child: !hasProfilePhoto ? const Icon(Icons.person, size: 50) : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                        onPressed: _selectProfilePicture,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'Your Name', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextFormField(controller: _businessNameController, decoration: const InputDecoration(labelText: 'Business Name', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email Address', border: OutlineInputBorder()),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextFormField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder()), keyboardType: TextInputType.phone),
            const SizedBox(height: 16),
            TextFormField(controller: _addressController, decoration: const InputDecoration(labelText: 'Address', border: OutlineInputBorder()), maxLines: 3),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Current Branch', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(_userProfile.currentBranch.value?.name ?? 'No branch selected'),
              trailing: const Icon(Icons.swap_horiz),
              onTap: _changeBranch,
            ),
          ],
        ),
      ),
    );
  }
}