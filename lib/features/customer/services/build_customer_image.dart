import 'dart:io';

import 'package:flutter/material.dart';

ImageProvider<Object>? buildCustomerImage(String imagePath) {
  if (imagePath.isEmpty) {
    imagePath = "https://placehold.co/100x100?text=No+Image";
  }
  if (imagePath.startsWith('http')) {
    return NetworkImage(imagePath);
  } else if (imagePath.isNotEmpty) {
    return FileImage(File(imagePath));
  }
  return null;
}
