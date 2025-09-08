import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class ImageSelectorWidget extends StatefulWidget {
  final List<File> selectedImages;
  final Function(List<File>) onImagesChanged;

  const ImageSelectorWidget({
    super.key,
    required this.selectedImages,
    required this.onImagesChanged,
  });

  @override
  State<ImageSelectorWidget> createState() => _ImageSelectorWidgetState();
}

class _ImageSelectorWidgetState extends State<ImageSelectorWidget> {
  final _picker = ImagePicker();

  Future<void> _pickImages() async {
    final permission = await Permission.photos.request();
    if (!permission.isGranted) {
      openAppSettings();
      return;
    }

    final images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      final newImages = [
        ...widget.selectedImages,
        ...images.map((x) => File(x.path)),
      ];
      widget.onImagesChanged(newImages);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Upload Images',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: _pickImages,
          child: Container(
            height: 150,
            color: Colors.grey.shade200,
            child: widget.selectedImages.isEmpty
                ? const Center(
                    child: Icon(Icons.add_photo_alternate_outlined, size: 40),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.selectedImages.length,
                    itemBuilder: (context, index) => Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            widget.selectedImages[index],
                            height: 150,
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: () => setState(
                              () => widget.selectedImages.removeAt(index),
                            ),
                            child: const Icon(
                              Icons.cancel,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
