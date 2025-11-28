import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  final List<Map<String, String>> _faqs = const [
    {
      'question': 'How do I add a new store?',
      'answer': 'Go to Settings > Account > Manage Stores. Tap the "+" button to create a new store branch.',
    },
    {
      'question': 'Can I use the app offline?',
      'answer': 'Yes! The app stores data locally on your device. However, some features like cloud backup (coming soon) will require an internet connection.',
    },
    {
      'question': 'How do I reset my password?',
      'answer': 'Currently, this is a local-only app, so there is no cloud password. If you set an App Lock PIN, you can reset it in the Security settings.',
    },
    {
      'question': 'How do I backup my data?',
      'answer': 'Go to Settings > Security & Support > Backup & Restore. You can export your database file from there.',
    },
    {
      'question': 'Who do I contact for support?',
      'answer': 'You can tap the "Contact Support" button in the Settings menu to email or call our support team directly.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frequently Asked Questions'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _faqs.length,
        itemBuilder: (context, index) {
          final faq = _faqs[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12.0),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.withOpacity(0.2)),
            ),
            child: ExpansionTile(
              title: Text(
                faq['question']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    faq['answer']!,
                    style: TextStyle(color: Colors.grey[700], height: 1.4),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}