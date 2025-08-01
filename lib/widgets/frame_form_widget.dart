import 'dart:io';
import 'package:flutter/material.dart';
import 'package:osm/data/models/frame_enums.dart';
import 'package:osm/data/models/frame_model.dart';
import 'package:osm/services/color_api_service.dart';
import 'package:osm/widgets/custom_button.dart';
import 'package:osm/widgets/multi_color_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class BuildFrameForm extends StatefulWidget {
  final void Function({
    required DateTime date,
    required FrameType frameType,
    required String companyName,
    required String name,
    required String code,
    required Color color,
    required String colorName,
    required int size,
    required int quantity,
    required double purchasePrice,
    required double salesPrice,
    required List<File> images,
    required String productCode,
  })
  onSubmit;

  const BuildFrameForm({super.key, required this.onSubmit});

  @override
  State<BuildFrameForm> createState() => _BuildFrameFormState();
}

class _BuildFrameFormState extends State<BuildFrameForm> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  final List<Color> _selectedColors = [];
  final List<File> _selectedImages = [];
  DateTime _selectedDate = DateTime.now();
  FrameType? _frameType;

  final _nameController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _codeController = TextEditingController();
  final _sizeController = TextEditingController();
  final _quantityController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _salesPriceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _sizeController.dispose();
    _quantityController.dispose();
    _purchasePriceController.dispose();
    _salesPriceController.dispose();
    _companyNameController.dispose();
    super.dispose();
  }

  Future<void> _pickMultipleImage() async {
    final permissionStatus = await Permission.photos.request();

    if (!mounted) return;

    if (permissionStatus.isPermanentlyDenied) {
      openAppSettings();
    }

    final List<XFile> pickedImages = await _picker.pickMultiImage();

    if (pickedImages.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(
          pickedImages
              .map((xfile) => File(xfile.path))
              .where(
                (file) => !_selectedImages.any((img) => img.path == file.path),
              )
              .toList(),
        );
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() && _frameType != null) {
      final String companyName = _companyNameController.text.trim();
      final String modelName = _nameController.text.trim();
      final String modelCode = _codeController.text.trim();
      final int size = int.parse(_sizeController.text);
      final int quantity = int.parse(_quantityController.text);
      final double purchasePrice = double.parse(_purchasePriceController.text);
      final double salesPrice = double.parse(_salesPriceController.text);

      final colorApiService = ColorApiService();

      for (Color color in _selectedColors) {
        final String colorName = await colorApiService.getColorName(
          color: color,
        );

        final String variantProductCode = FrameVariant.generateProductCode(
          _frameType!,
          companyName,
          modelName,
          modelCode,
          colorName,
          size,
        );

        widget.onSubmit(
          date: _selectedDate,
          images: _selectedImages,
          frameType: _frameType!,
          companyName: companyName,
          name: _nameController.text.trim(),
          code: _codeController.text.trim(),
          color: color,
          colorName: colorName,
          size: size,
          quantity: quantity,
          purchasePrice: purchasePrice,
          salesPrice: salesPrice,
          productCode: variantProductCode,
        );
      }
    }
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickMultipleImage,
      child: Container(
        width: double.infinity,
        height: 150,
        color: Colors.grey.shade200,
        child: _selectedImages.isEmpty
            ? const Center(
                child: Icon(Icons.add_photo_alternate_outlined, size: 40),
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _selectedImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Image.file(_selectedImages[index], height: 150),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () {
                              setState(() => _selectedImages.removeAt(index));
                            },
                            child: const Icon(
                              Icons.cancel,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildSelectDate() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _selectDate(context),
        child: Container(
          padding: EdgeInsets.only(top: 10),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.calendar_today, size: 20),
                  const Text('Select Date', style: TextStyle(fontSize: 20)),
                ],
              ),
              Text(
                DateFormat.yMMMMd().format(_selectedDate),
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool isNumeric = false,
    bool isDecimal = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: isDecimal
          ? const TextInputType.numberWithOptions(decimal: true)
          : (isNumeric ? TextInputType.number : TextInputType.text),
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Enter $label';
        if (isNumeric && int.tryParse(value) == null) {
          return 'Enter valid $label';
        }
        if (isDecimal && double.tryParse(value) == null) {
          return 'Enter valid $label';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Upload Product Images',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildImagePicker(),
          _buildSelectDate(),
          const SizedBox(height: 10),
          DropdownButtonFormField<FrameType>(
            decoration: const InputDecoration(labelText: 'Frame Type'),
            value: _frameType,
            items: FrameType.values.map((type) {
              return DropdownMenuItem(value: type, child: Text(type.name));
            }).toList(),
            onChanged: (type) => setState(() => _frameType = type),
            validator: (value) =>
                value == null ? 'Please select a frame type' : null,
          ),
          _buildTextField(_companyNameController, 'Company Name'),
          _buildTextField(_nameController, 'Model Name'),
          _buildTextField(_codeController, 'Model Code'),
          MultiColorPicker(
            initialColors: _selectedColors,
            onColorsChanged: (colors) {
              setState(() {
                _selectedColors
                  ..clear()
                  ..addAll(colors);
              });
            },
          ),
          _buildTextField(_sizeController, 'Model Size', isNumeric: true),
          _buildTextField(_quantityController, 'Quantity', isNumeric: true),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .4,
                child: _buildTextField(
                  _purchasePriceController,
                  'Purchase Price',
                  isDecimal: true,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _buildTextField(
                  _salesPriceController,
                  'Sales Price',
                  isDecimal: true,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          CustomButton(
            onPressed: _submitForm,
            label: 'Save Stock',
            icon: Icons.check,
          ),
        ],
      ),
    );
  }
}
