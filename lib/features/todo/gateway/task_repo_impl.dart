import 'package:dartz/dartz.dart' hide Task;
import 'package:injectable/injectable.dart';
import 'package:trackt/core/errors/exceptions.dart';
import 'package:trackt/core/errors/failures.dart';
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/task/task.dart';
import 'package:trackt/features/todo/external/persistence/task_store.dart';
import 'package:trackt/features/todo/gateway/task_repo.dart';



@LazySingleton(as: TaskRepo)
class TaskRepoImpl implements TaskRepo {
  final TaskStore taskStore;

  TaskRepoImpl(this.taskStore);

  @override
  Future<Either<Failure, Task>> createTask(
      {required Task task, required User user}) async {
    try {
      final createdTask = await taskStore.createTask(task: task, user: user);
      return Right(createdTask);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deleteTask(
      {required String id, required User user}) async {
    try {
      final deletedTaskId = await taskStore.deleteTask(id: id, user: user);
      return Right(deletedTaskId);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Task>>> getTasksBySectionId(
      {required String sectionId, required User user}) async {
    try {
      final tasks =
          await taskStore.getTasksBySectionId(sectionId: sectionId, user: user);
      return Right(tasks);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Task>> updateTask(
      {required Task task, required User user}) async {
    try {
      final updatedTask = await taskStore.updateTask(task: task, user: user);
      return Right(updatedTask);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Task>> moveTask({required Task task, required User user})  async {
    try {
      final movedTask = await taskStore.moveTask(task: task, user: user);
      return Right(movedTask);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
