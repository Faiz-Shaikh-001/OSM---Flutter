import 'package:flutter/material.dart';
import 'package:osm/features/dashboard/presentation/data/models/recent_activities.dart';

class DashboardRecentActivitiesSection extends StatelessWidget {
  final List<ActivityModel> activities;

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
        ListView.builder(
          itemCount: activities.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final activity = activities[index];
            if (activities.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "No recent activities yet.",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              );
            } else {
              return ListTile(
                title: Text(activity.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(activity.subtitle),
                    Text(_formatTimeAgo(activity.time)),
                  ],
                ),
              );
            }
          },
        ),
      ],
    );
  }

  String _formatTimeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);

    if (diff.inMinutes < 1) return "Just now";
    if (diff.inMinutes < 60) return "${diff.inMinutes} mins ago";
    if (diff.inHours < 24) return "${diff.inHours} hours ago";
    return "${diff.inDays} days ago";
  }
}
