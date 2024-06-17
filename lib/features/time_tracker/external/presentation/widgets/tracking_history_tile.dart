import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackt/core/extensions/duration_extension.dart';
import 'package:trackt/features/time_tracker/external/models/time_tracker.dart';
import 'package:trackt/features/todo/external/models/task/task.dart';

class TrackingHistoryTile extends StatelessWidget {
  const TrackingHistoryTile(
      {super.key, required this.task, required this.trackers});

  final Task task;
  final List<TimeTracker> trackers;

  @override
  Widget build(BuildContext context) {
    final totalElapsed = trackers.fold(const Duration(),
        (previousValue, element) => previousValue + element.elapsed!);

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.6),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.content,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Total Time: ${totalElapsed.toFormattedString()}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            if (trackers.isNotEmpty)
              Text(
                  'Completed at: ${DateFormat('MMMM dd, yyyy ==== hh:mm a').format(trackers.first.endTime!)}')
          ],
        ));
  }
}
