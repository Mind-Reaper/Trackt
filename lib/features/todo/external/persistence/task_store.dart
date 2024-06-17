import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/task/task.dart';

abstract class TaskStore {
  Future<Task> createTask({required Task task, required User user});

  Future<String> deleteTask({required String id, required User user});

  Future<Task> updateTask({required Task task, required User user});

  Future<Task> moveTask(
      {required Task task,  required User user});

  Future<List<Task>> getTasksBySectionId(
      {required String sectionId, required User user});
}
