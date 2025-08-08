// import 'dart:collection';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:osm/data/models/frame_model.dart';
// import 'dart:io';

// import 'package:osm/utils/product_type.dart';

// class UpdateStockScreen extends StatefulWidget {
//   const UpdateStockScreen({super.key});

//   @override
//   State<UpdateStockScreen> createState() => _UpdateStockScreenState();
// }

// class _UpdateStockScreenState extends State<UpdateStockScreen> {
//   dynamic _product;
//   ProductType? _productType;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     // Get arguments as a Map
//     final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

//     _product = args['product'];
//     _productType = args['productType'];

//     late TextEditingController nameController;
//     late TextEditingController companyNameController;
//     late TextEditingController quantityController;
//     late TextEditingController colorController;
//     late TextEditingController sizeController;
//     late TextEditingController purchasePriceController;
//     late TextEditingController salesPriceController;

//     int stockCount = 0;
//     String imageUrl = '';
//     File? newImageFile;

//     final ImagePicker _picker = ImagePicker();

//     // Initialize controllers from the _product object
//     if (_productType == ProductType.frame && _product is FrameModel){
//       final frame = _product as FrameModel;

//       final variant = frame.variants.first;

//       nameController = TextEditingController(text: frame.name);
//       companyNameController = TextEditingController(text: frame.companyName);
//       quantityController = TextEditingController(text: (variant.quantity?? 0).toString());

//     }

//   }

//   int stockCount = 0;
//   String imageUrl = '';
//   File? newImageFile;

//   final ImagePicker _picker = ImagePicker();

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     final Map<String, dynamic> item =
//         ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

//     nameController = TextEditingController(text: item['name']);
//     quantityController = TextEditingController(
//       text: item['quantity'].toString(),
//     );
//     purchasePriceController = TextEditingController(
//       text: item['purchase_price'].toString(),
//     );
//     sellingPriceController = TextEditingController(
//       text: item['selling_price'].toString(),
//     );
//     colorController = TextEditingController(text: item['color']);
//     sizeController = TextEditingController(text: item['size']);

//     stockCount = item['stock'];
//     imageUrl = item['image'];
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     quantityController.dispose();
//     purchasePriceController.dispose();
//     sellingPriceController.dispose();
//     colorController.dispose();
//     sizeController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(
//       source: await _showImageSourceDialog(),
//     );

//     if (pickedFile != null) {
//       setState(() {
//         newImageFile = File(pickedFile.path);
//         imageUrl = '';
//       });
//     }
//   }

//   Future<ImageSource> _showImageSourceDialog() async {
//     return await showDialog<ImageSource>(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text("Select Image Source"),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context, ImageSource.camera),
//                 child: const Text("Camera"),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.pop(context, ImageSource.gallery),
//                 child: const Text("Gallery"),
//               ),
//             ],
//           ),
//         ) ??
//         ImageSource.gallery;
//   }

//   void _updateStock() {
//     final updatedData = {
//       'name': nameController.text.trim(),
//       'quantity': int.tryParse(quantityController.text) ?? 0,
//       'color': colorController.text.trim(),
//       'size': sizeController.text.trim(),
//       'purchase_price': double.tryParse(purchasePriceController.text) ?? 0.0,
//       'selling_price': double.tryParse(sellingPriceController.text) ?? 0.0,
//       'stock': stockCount,
//       'image': newImageFile?.path ?? imageUrl,
//     };

//     debugPrint('Updated Item: $updatedData');

//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(const SnackBar(content: Text('Stock updated successfully')));

//     Navigator.of(context).pop(updatedData);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Edit Stock')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             Text(
//               'Current Stock: $stockCount',
//               style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//             ),
//             const SizedBox(height: 24),

//             const Text(
//               'Edit Image:',
//               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//             ),
//             const SizedBox(height: 8),

//             GestureDetector(
//               onTap: _pickImage,
//               child: Stack(
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     height: 150,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(8),
//                       image: newImageFile != null
//                           ? DecorationImage(
//                               image: FileImage(newImageFile!),
//                               fit: BoxFit.cover,
//                             )
//                           : imageUrl.isNotEmpty
//                           ? DecorationImage(
//                               image: NetworkImage(imageUrl),
//                               fit: BoxFit.cover,
//                             )
//                           : null,
//                     ),
//                     child: (newImageFile == null && imageUrl.isEmpty)
//                         ? const Center(child: Icon(Icons.add_a_photo, size: 50))
//                         : null,
//                   ),
//                   Positioned(
//                     top: 8,
//                     right: 8,
//                     child: Container(
//                       padding: const EdgeInsets.all(6),
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.black54,
//                       ),
//                       child: const Icon(
//                         Icons.edit,
//                         color: Colors.white,
//                         size: 18,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 16),

//             TextFormField(
//               controller: nameController,
//               decoration: const InputDecoration(
//                 labelText: 'Product Name',
//                 suffixIcon: Icon(Icons.edit, size: 20),
//               ),
//             ),
//             const SizedBox(height: 12),

//             TextFormField(
//               controller: quantityController,
//               decoration: const InputDecoration(
//                 labelText: 'Quantity',
//                 suffixIcon: Icon(Icons.edit, size: 20),
//               ),
//               keyboardType: TextInputType.number,
//             ),
//             const SizedBox(height: 12),

//             TextFormField(
//               controller: colorController,
//               decoration: const InputDecoration(
//                 labelText: 'Color',
//                 suffixIcon: Icon(Icons.edit, size: 20),
//               ),
//             ),
//             const SizedBox(height: 12),

//             TextFormField(
//               controller: sizeController,
//               decoration: const InputDecoration(
//                 labelText: 'Size',
//                 suffixIcon: Icon(Icons.edit, size: 20),
//               ),
//             ),
//             const SizedBox(height: 12),

//             TextFormField(
//               controller: purchasePriceController,
//               decoration: const InputDecoration(
//                 labelText: 'Purchase Price',
//                 suffixIcon: Icon(Icons.edit, size: 20),
//               ),
//               keyboardType: TextInputType.number,
//             ),
//             const SizedBox(height: 12),

//             TextFormField(
//               controller: sellingPriceController,
//               decoration: const InputDecoration(
//                 labelText: 'Selling Price',
//                 suffixIcon: Icon(Icons.edit, size: 20),
//               ),
//               keyboardType: TextInputType.number,
//             ),
//             const SizedBox(height: 20),

//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 backgroundColor: Colors.blueAccent,
//                 foregroundColor: Colors.white,
//               ),
//               onPressed: _updateStock,
//               child: const Text('Edit Stock'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class UpdateStockScreen extends StatelessWidget {
  const UpdateStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Update stock here!!"));
  }
}
