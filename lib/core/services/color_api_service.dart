import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../utils/color_name_cache.dart';

class ColorApiService {
  Future<String> getColorName({required Color color}) async {
    final hex = color.value
        .toRadixString(16)
        .padLeft(8, '0')
        .substring(2)
        .toUpperCase();
    String? colorName = ColorNameCache.get(hex);

    if (colorName == null) {
      try {
        final baseUrl = 'https://www.thecolorapi.com/id?hex=$hex';
        final uri = Uri.parse(baseUrl);
        final response = await http
            .get(uri)
            .timeout(const Duration(seconds: 3));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final fetchedName = data['name']?['value'];

          if (fetchedName is String && fetchedName.isNotEmpty) {
            colorName = fetchedName;
          }
        } else {
          debugPrint('ColorAPI failed with status: ${response.statusCode}');
          colorName = '#$hex';
        }
      } catch (e) {
        debugPrint("Error calling colorapi: $e.");
        colorName = '#$hex';
      }

      ColorNameCache.set(hex, colorName ?? '#$hex');
    }

    return colorName ?? '#$hex';
  }
}
