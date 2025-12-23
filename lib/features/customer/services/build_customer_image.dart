import 'dart:io';

import 'package:flutter/material.dart';

ImageProvider<Object>? buildCustomerImage(String? imagePath) {
  if (imagePath == null) return null;
  if (imagePath.startsWith('http')) {
    return NetworkImage(imagePath);
  } else if (imagePath.isNotEmpty) {
    return FileImage(File(imagePath));
  }
  return null;
}
