import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trackt/core/common/usecase.dart';
import 'package:trackt/core/errors/failures.dart';
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/project/project.dart';
import 'package:trackt/features/todo/gateway/project_repo.dart';


@named
@LazySingleton(as: UseCase<List<Project>, User>)
class GetProjects implements UseCase<List<Project>, User> {
  final ProjectRepo projectRepo;

  GetProjects(this.projectRepo);

  @override
  Future<Either<Failure, List<Project>>> call(User user) {
    return projectRepo.getProjects(user: user);
  }
}