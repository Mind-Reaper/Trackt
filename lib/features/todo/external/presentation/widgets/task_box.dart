import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackt/core/extensions/duration_extension.dart';
import 'package:trackt/features/todo/external/models/task/task.dart';

class TaskBox extends StatefulWidget {
  const TaskBox(
      {super.key,
      required this.task,
      this.onTaskCreated,
      this.onCanceled,
      this.onTap,
      this.elapsed = const Duration()});

  final Task task;
  final ValueChanged<String>? onTaskCreated;
  final VoidCallback? onCanceled;
  final VoidCallback? onTap;
  final Duration elapsed;

  @override
  State<TaskBox> createState() => _TaskBoxState();
}

class _TaskBoxState extends State<TaskBox> {
  final textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newTask = widget.task.id.isEmpty;

    return GestureDetector(
      onTap: newTask
          ? null
          : () {
              widget.onTap?.call();
            },
      child: Container(
          height: newTask ? 170 : 200,
          decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.inversePrimary.withOpacity(0.6),
              borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(12),
          child: newTask ? buildNewTask() : buildExistingTask()),
    );
  }

  Widget buildNewTask() {
    return Column(
      children: [
        Expanded(
            child: TextField(
          controller: textController,
          autofocus: true,
          minLines: 2,
          maxLines: 2,
          maxLength: 70,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16))),
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: () {
                if (textController.text.trim().isEmpty) {
                  textController.clear();
                  return;
                }
                widget.onTaskCreated?.call(textController.text);
              },
              label: const Text('Create'),
              icon: const Icon(Icons.add_circle_outline_outlined),
            ),
            TextButton(
                onPressed: () {
                  widget.onCanceled?.call();
                },
                child: const Text('Cancel'))
          ],
        )
      ],
    );
  }

  Widget buildExistingTask() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(DateFormat('MMMM dd, yyyy').format(widget.task.createdAt)),
        const SizedBox(height: 4),
        Text(
          widget.task.content,
          style: Theme.of(context).textTheme.titleMedium,
          maxLines: 2,
        ),
        Expanded(
          child: Text(
            widget.task.description,
          ),
        ),
        Row(
          children: [
            const Icon(Icons.comment_outlined),
            const SizedBox(
              width: 6,
            ),
            Text(widget.task.commentCount.toString()),
            const Spacer(),
            const Icon(Icons.timelapse),
            const SizedBox(
              width: 6,
            ),
            Text(widget.elapsed.toFormattedString()),
          ],
        )
      ],
    );
  }
}
