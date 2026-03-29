import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSupport extends StatelessWidget {
  const ContactSupport({super.key});

  Future<void> _launchEmail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'support@opticsstore.com',
      query: 'subject=Support Request',
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _launchPhone() async {
    final uri = Uri(
      scheme: 'tel',
      path: '+18001234567',
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ───── Drag Handle ─────
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.dividerColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ───── Title ─────
          const Text(
            'Contact Support',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          // ───── Email ─────
          ListTile(
            leading: _CircleIcon(
              icon: Icons.email_outlined,
              backgroundColor: Colors.blue,
            ),
            title: const Text('Email Us'),
            subtitle: const Text('support@opticsstore.com'),
            onTap: _launchEmail,
          ),

          // ───── Call ─────
          ListTile(
            leading: _CircleIcon(
              icon: Icons.call_outlined,
              backgroundColor: Colors.green,
            ),
            title: const Text('Call Us'),
            subtitle: const Text('+1 800 123 4567'),
            onTap: _launchPhone,
          ),
        ],
      ),
    );
  }
}

/// ─────────────────────────
/// Reusable Circular Icon
/// ─────────────────────────
class _CircleIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;

  const _CircleIcon({
    required this.icon,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: backgroundColor,
      child: Icon(
        icon,
        color: Colors.white,
        size: 22,
      ),
    );
  }
}
