import 'package:flutter/material.dart';

import 't_n_c_screen.dart';
import 'privacy_policy_screen.dart';
import 'licenses_screen.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: ListView(
        children: [
          const _AboutTile(
            icon: Icons.info_outline,
            title: 'App Version',
            subtitle: 'v1.0.0',
          ),
          const Divider(height: 1),

          _AboutTile(
            icon: Icons.description_outlined,
            title: 'Terms & Conditions',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TermsConditionsScreen(),
                ),
              );
            },
          ),
          const Divider(height: 1),

          _AboutTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PrivacyPolicyScreen(),
                ),
              );
            },
          ),
          const Divider(height: 1),

          _AboutTile(
            icon: Icons.code_outlined,
            title: 'Open Source Licenses',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LicensesScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AboutTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const _AboutTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: onTap != null
          ? const Icon(Icons.arrow_forward_ios, size: 16)
          : null,
      onTap: onTap,
    );
  }
}
