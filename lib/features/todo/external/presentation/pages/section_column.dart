import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trackt/core/state_controllers.dart';
import 'package:trackt/features/todo/external/models/section/section.dart';
import 'package:trackt/features/todo/external/models/task/task.dart';
import 'package:trackt/features/todo/external/presentation/pages/task_detail_page.dart';
import 'package:trackt/features/todo/external/presentation/widgets/task_box.dart';
import 'package:trackt/shared/widgets/messenger.dart';

class SectionColumn extends ConsumerStatefulWidget {
  const SectionColumn({super.key, required this.section});

  final Section section;

  @override
  ConsumerState<SectionColumn> createState() => _SectionColumnState();
}

class _SectionColumnState extends ConsumerState<SectionColumn> {
  Task? newTask;

  @override
  Widget build(BuildContext context) {
    final sectionTasks = ref
        .watch(projectController)
        .tasks
        .where((e) => e.sectionId == widget.section.id)
        .toList();
    final projectNotifier = ref.read(projectController.notifier);
    final trackerNotifier = ref.read(trackerController.notifier);
    final trackerState = ref.watch(trackerController);

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.section.name.description,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(width: 4),
              Text(
                '${sectionTasks.length}',
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const Divider(),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    if (index == sectionTasks.length && newTask != null) {
                      return TaskBox(
                        task: newTask!,
                        onTaskCreated: (content) async {
                          projectNotifier.showLoader();
                          final task = newTask!.copyWith(content: content);
                          await projectNotifier
                              .createTask(task)
                              .then((success) {
                            if (success) {
                              newTask = null;
                              setState(() {});
                            } else {
                              Messenger.showSnackBar(
                                  context, 'Failed to create task');
                            }
                          });
                          projectNotifier.hideLoader();
                        },
                        onCanceled: () {
                          newTask = null;
                          setState(() {});
                        },
                      );
                    }
                    final task = sectionTasks[index];
                    final taskTrackers = trackerState.trackers
                        .where((e) => e.taskId == task.id)
                        .toList();
                    final totalElapsed = taskTrackers.fold<Duration>(
                        const Duration(),
                        (previousValue, element) =>
                            previousValue +
                            (element.elapsed ?? const Duration()));

                    return TaskBox(
                      task: task,
                      elapsed: totalElapsed,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => TaskDetailPage(task: task)));
                      },
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(
                        height: 8,
                      ),
                  itemCount: sectionTasks.length + (newTask == null ? 0 : 1))),
          const Divider(),
          TextButton.icon(
            onPressed: () {
              newTask = Task(
                content: '',
                description: '',
                createdAt: DateTime.now(),
                order: sectionTasks.length,
                projectId: widget.section.projectId,
                url: '',
                sectionId: widget.section.id,
              );
              setState(() {});
            },
            label: const Text('Add Task'),
            icon: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
