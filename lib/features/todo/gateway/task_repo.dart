import 'package:dartz/dartz.dart' hide Task;

import 'package:trackt/core/errors/failures.dart';
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/task/task.dart';


abstract class TaskRepo {

  Future<Either<Failure, Task>> createTask(
      {required Task task, required User user});


  Future<Either<Failure, String>> deleteTask(
      {required String id, required User user});


  Future<Either<Failure, List<Task>>> getTasksBySectionId(
      {required String sectionId, required User user});


  Future<Either<Failure, Task>> updateTask(
      {required Task task, required User user});


  Future<Either<Failure, Task>> moveTask({required Task task, required User user});
}
