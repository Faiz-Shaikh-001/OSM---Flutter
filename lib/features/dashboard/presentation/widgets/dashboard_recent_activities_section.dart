import 'package:flutter/material.dart';
import 'package:osm/features/dashboard/presentation/models/activity_ui_model.dart';

class DashboardRecentActivitiesSection extends StatelessWidget {
  final List<ActivityUiModel> activities;

  const DashboardRecentActivitiesSection({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            'Recent Activities',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 10),

        if (activities.isEmpty)
          Padding(
            padding: const EdgeInsets.all(
              40,
            ), // Increased padding for a better look
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.history, color: Colors.grey[300], size: 48),
                  const SizedBox(height: 12),
                  const Text(
                    "Your recent store activity will appear here.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: activities.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final activity = activities[index];

              return ListTile(
                leading: Icon(activity.icon),
                title: Text(activity.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (activity.subtitle.isNotEmpty) Text(activity.subtitle),
                    Text(
                      activity.time,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}
