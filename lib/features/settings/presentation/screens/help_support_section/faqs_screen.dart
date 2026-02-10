import 'package:flutter/material.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({super.key});

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  int? expandedIndex;

  final List<Map<String, String>> faqs = [
    {
      'question': 'How do I add a new store?',
      'answer':
          'Go to Settings → Inventory Settings → Add Store and fill in the details.',
    },
    {
      'question': 'Can I use the app offline?',
      'answer':
          'Yes, most features work offline. Data syncs when online.',
    },
    {
      'question': 'How do I reset my password?',
      'answer':
          'Go to Account → Change Password.',
    },
    {
      'question': 'How do I backup my data?',
      'answer':
          'Use Settings → Security & Support → Backup & Restore.',
    },
    {
      'question': 'Who do I contact for support?',
      'answer':
          'Use the Contact Support section.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Frequently Asked Questions')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final isExpanded = expandedIndex == index;

          return Card(
            elevation: 0,
            color: theme.colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: theme.dividerColor.withOpacity(0.2),
              ),
            ),
            margin: const EdgeInsets.only(bottom: 12),
            child: ExpansionTile(
              key: Key(index.toString()),
              initiallyExpanded: isExpanded,
              onExpansionChanged: (expanded) {
                setState(() {
                  expandedIndex = expanded ? index : null;
                });
              },
              title: Text(
                faqs[index]['question']!,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    faqs[index]['answer']!,
                    style: theme.textTheme.bodyMedium,
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
