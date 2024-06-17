import 'package:dartz/dartz.dart' hide Task;
import 'package:injectable/injectable.dart';
import 'package:trackt/core/common/usecase.dart';
import 'package:trackt/core/errors/failures.dart';
import 'package:trackt/core/utilities/pair.dart';
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/gateway/task_repo.dart';


@named
@LazySingleton(as: UseCase<String, Pair<String, User>>)
class DeleteTask implements UseCase<String, Pair<String, User>> {
  final TaskRepo taskRepo;

  DeleteTask(this.taskRepo);

  @override
  Future<Either<Failure, String>> call(Pair<String, User> params) {
    return taskRepo.deleteTask(id: params.first, user: params.second);
  }
}