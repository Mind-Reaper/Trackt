import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trackt/core/extensions/duration_extension.dart';
import 'package:trackt/core/state_controllers.dart';
import 'package:trackt/features/todo/external/models/task/task.dart';
import 'package:trackt/features/todo/external/presentation/widgets/comment_box.dart';
import 'package:trackt/shared/widgets/loading_overlay.dart';
import 'package:trackt/shared/widgets/messenger.dart';

import 'package:trackt/features/todo/external/models/comment/comment.dart';

class TaskDetailPage extends ConsumerStatefulWidget {
  const TaskDetailPage({super.key, required this.task});

  final Task task;

  @override
  ConsumerState<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends ConsumerState<TaskDetailPage> {
  bool editing = false;
  bool deleteMode = false;

  late Task task;

  TextEditingController contentController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  List<Comment> comments = [];

  @override
  void initState() {
    task = widget.task;
    contentController.text = widget.task.content;
    descriptionController.text = widget.task.description;
    super.initState();
    fetchComments();
  }

  Future<void> editTask({String? sectionId}) async {
    FocusScope.of(context).unfocus();
    final projectNotifier = ref.read(projectController.notifier);
    projectNotifier.showLoader();
    final taskUpdate = task.copyWith(
        content: contentController.text,
        description: descriptionController.text,
        sectionId: sectionId ?? task.sectionId);
    await projectNotifier
        .updateTask(taskUpdate, move: sectionId != null)
        .then((success) {
      projectNotifier.hideLoader();
      if (success) {
        setState(() {
          editing = false;
          task = taskUpdate;
        });
      } else {
        Messenger.showSnackBar(context, 'Failed to save task');
      }
    });
  }

  Future<void> fetchComments() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final projectNotifier = ref.read(projectController.notifier);
      projectNotifier.showLoader();
      projectNotifier.getComments(task.id).then((comments) {
        projectNotifier.hideLoader();
        setState(() {
          this.comments = comments;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final projectNotifier = ref.read(projectController.notifier);
    final projectState = ref.watch(projectController);

    final trackerNotifier = ref.read(trackerController.notifier);
    final trackerState = ref.watch(trackerController);

    final sections = projectState.sections;

    final taskTrackers =
        trackerState.trackers.where((e) => e.taskId == task.id).toList();
    final totalElapsed = taskTrackers.fold<Duration>(
        const Duration(),
        (previousValue, element) =>
            previousValue + (element.elapsed ?? const Duration()));

    bool isRunningTracker = trackerState.currentTracker.taskId == task.id &&
        trackerState.currentTracker.isRunning;

    return LoadingOverlay(
      loading: projectState.loading,
      message: editing
          ? 'Editing Task'
          : deleteMode
              ? 'Deleting Task'
              : null,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            actions: [
              if (deleteMode) ...[
                TextButton(
                    onPressed: () {
                      setState(() {
                        deleteMode = !deleteMode;
                      });
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () async {
                      projectNotifier.showLoader();
                      await projectNotifier.deleteTask(task.id).then((success) {
                        trackerNotifier.stopTracking(task.id);
                        projectNotifier.hideLoader();
                        if (success) {
                          Navigator.of(context).pop();
                        } else {
                          Messenger.showSnackBar(
                              context, 'Failed to delete task');
                        }
                      });
                    },
                    child: const Text(
                      'Delete Task',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    ))
              ] else if (editing) ...[
                TextButton(
                    onPressed: () {
                      setState(() {
                        editing = !editing;
                      });
                    },
                    child: const Text('Discard',
                        style: TextStyle(color: Colors.red))),
                TextButton(
                    onPressed: () {
                      editTask();
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    ))
              ] else ...[
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      editing = !editing;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      deleteMode = !deleteMode;
                    });
                  },
                ),
              ]
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButton<String>(
                          value: task.sectionId,
                          items: sections
                              .map((e) => DropdownMenuItem(
                                    value: e.id,
                                    child: Text(e.name.description),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            editTask(sectionId: value);
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.timelapse),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              totalElapsed.toFormattedString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(isRunningTracker
                                      ? Icons.stop
                                      : Icons.play_arrow),
                                  onPressed: () {
                                    if (isRunningTracker) {
                                      trackerNotifier.stopTracking(task.id);
                                    } else {
                                      trackerNotifier.startTracking(task.id);
                                    }
                                  },
                                ),
                                if (isRunningTracker)
                                  Text(
                                      trackerState.elapsed.toFormattedString()),
                              ],
                            ),
                          ],
                        ),
                        TextField(
                            controller: contentController,
                            enabled: editing,
                            minLines: 1,
                            maxLines: null,
                            maxLength: editing ? 70 : null,
                            textInputAction: TextInputAction.done,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                            decoration: editing
                                ? InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(16)))
                                : const InputDecoration(
                                    border: InputBorder.none,
                                  )),
                        const SizedBox(height: 16),
                        TextField(
                            controller: descriptionController,
                            enabled: editing,
                            minLines: editing ? 4 : 1,
                            maxLines: null,
                            maxLength: editing ? 500 : null,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w500),
                            decoration: editing
                                ? InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: 'Description',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(16)))
                                : const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Description')),
                        const SizedBox(height: 16),
                        const Divider(),
                        Text('Comments (${comments.length})',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 8,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            return CommentBox(
                                comment: comments[index],
                                onDeleted: () {
                                  projectNotifier.showLoader();
                                  projectNotifier
                                      .deleteComment(comments[index].id)
                                      .then((commentId) {
                                    projectNotifier.hideLoader();
                                    if (commentId != null) {
                                      setState(() {
                                        comments.removeAt(index);
                                      });
                                    } else {
                                      Messenger.showSnackBar(
                                          context, 'Failed to delete comment');
                                    }
                                  });
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: commentController,
                minLines: 1,
                maxLines: 2,
                decoration: InputDecoration(
                    hintText: 'Add a comment',
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (commentController.text.trim().isEmpty) {
                            return;
                          }
                          FocusScope.of(context).unfocus();
                          projectNotifier.showLoader();
                          projectNotifier
                              .createComment(Comment(
                                  content: commentController.text,
                                  taskId: task.id,
                                  postedAt: DateTime.now()))
                              .then((comment) {
                            projectNotifier.hideLoader();
                            if (comment != null) {
                              setState(() {
                                commentController.clear();
                                comments.add(comment);
                              });
                            } else {
                              Messenger.showSnackBar(
                                  context, 'Failed to create comment');
                            }
                          });
                        },
                        icon: const Icon(Icons.send)),
                    fillColor: Colors.white,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    )),
              ),
              Container(
                height: 24,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
