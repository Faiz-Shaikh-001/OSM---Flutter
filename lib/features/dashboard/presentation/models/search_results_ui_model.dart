import 'package:flutter/material.dart';

enum SearchResultType {
  order,
  frame,
  lens,
  customer
}

class SearchResultUiModel {
  final String title;
  final String subtitle;
  final SearchResultType type;
  final IconData icon;
  final Object payload;

  const SearchResultUiModel({
    required this.title,
    required this.subtitle,
    required this.type,
    required this.icon,
    required this.payload,
  });
}