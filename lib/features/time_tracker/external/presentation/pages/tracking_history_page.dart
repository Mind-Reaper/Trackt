import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trackt/core/state_controllers.dart';
import 'package:trackt/features/time_tracker/external/presentation/widgets/tracking_history_tile.dart';
import 'package:trackt/features/todo/external/models/section/section.dart';
import 'package:trackt/features/todo/external/presentation/pages/task_detail_page.dart';

class TrackingHistoryPage extends ConsumerStatefulWidget {
  const TrackingHistoryPage({super.key});

  @override
  ConsumerState<TrackingHistoryPage> createState() =>
      _TrackingHistoryPageState();
}

class _TrackingHistoryPageState extends ConsumerState<TrackingHistoryPage> {
  @override
  Widget build(BuildContext context) {
    final projectNotifier = ref.read(projectController.notifier);
    final projectState = ref.watch(projectController);
    final trackerNotifier = ref.read(trackerController.notifier);
    final trackerState = ref.watch(trackerController);

    final sections = projectState.sections;

    final completedSection =
        sections.firstWhere((e) => e.name == SectionName.done);

    final sectionTasks = projectState.tasks
        .where((e) => e.sectionId == completedSection.id)
        .toList();

    final trackers = trackerState.trackers;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Completed Tracking History'),
        ),
        body: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            itemBuilder: (context, index) {
              final task = sectionTasks[index];
              final taskTrackers = trackers
                  .where((e) => e.taskId == task.id && e.endTime != null)
                  .toList()
                ..sort((a, b) => b.endTime!.compareTo(a.endTime!));

              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => TaskDetailPage(task: task)));
                  },
                  child:
                      TrackingHistoryTile(task: task, trackers: taskTrackers));
            },
            separatorBuilder: (_, __) => const SizedBox(
                  height: 16,
                ),
            itemCount: sectionTasks.length));
  }
}
