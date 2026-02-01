import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget trailing;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.title,
    required this.icon,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
