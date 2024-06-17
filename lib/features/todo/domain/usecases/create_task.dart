import 'package:dartz/dartz.dart' hide Task;
import 'package:injectable/injectable.dart';
import 'package:trackt/core/common/usecase.dart';
import 'package:trackt/core/errors/failures.dart';
import 'package:trackt/core/utilities/pair.dart';
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/task/task.dart';
import 'package:trackt/features/todo/gateway/task_repo.dart';

@named
@LazySingleton(as: UseCase<Task, Pair<Task, User>>)
class CreateTask implements UseCase<Task, Pair<Task, User>> {
  final TaskRepo taskRepo;

  CreateTask(this.taskRepo);

  @override
  Future<Either<Failure, Task>> call(Pair<Task, User> params) async {
    return await taskRepo.createTask(task: params.first, user: params.second);
  }
}
