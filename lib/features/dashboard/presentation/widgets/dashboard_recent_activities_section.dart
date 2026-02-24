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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Recent Activities',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        if (activities.isEmpty)
          _buildEmptyState()
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activities.length,
            separatorBuilder: (_, _) => Divider(
              height: 1,
              indent: 72, 
              color: Colors.grey[100],
            ),
            itemBuilder: (context, index) {
              final activity = activities[index];

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: activity.color.withValues(
                       alpha: .1,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(activity.icon, color: activity.color, size: 20),
                ),
                title: Text(
                  activity.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                subtitle: activity.subtitle.isNotEmpty
                    ? Text(
                        activity.subtitle,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      )
                    : null,
                trailing: Text(
                  activity.time,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[500],
                    fontSize: 11,
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.history, color: Colors.grey[200], size: 64),
            const SizedBox(height: 16),
            const Text(
              "No recent activity to show",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
