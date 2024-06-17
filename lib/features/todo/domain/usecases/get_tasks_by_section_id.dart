import 'package:dartz/dartz.dart' hide Task;
import 'package:injectable/injectable.dart';
import 'package:trackt/core/common/usecase.dart';
import 'package:trackt/core/errors/failures.dart';
import 'package:trackt/core/utilities/pair.dart';
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/task/task.dart';
import 'package:trackt/features/todo/gateway/task_repo.dart';


@named
@LazySingleton(as: UseCase<List<Task>, Pair<String, User>>)
class GetTasksBySectionId implements UseCase<List<Task>, Pair<String, User>> {
  final TaskRepo taskRepo;

  GetTasksBySectionId(this.taskRepo);

  @override
  Future<Either<Failure, List<Task>>> call(Pair<String, User> params) {
    return taskRepo.getTasksBySectionId(
        sectionId: params.first, user: params.second);
  }
}
