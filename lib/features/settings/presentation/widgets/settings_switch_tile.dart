import 'package:flutter/material.dart';

class SettingsSwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const SettingsSwitchTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      secondary: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      value: value,
      onChanged: onChanged ?? (_) {},
    );
  }
}