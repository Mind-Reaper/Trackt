import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trackt/core/common/usecase.dart';
import 'package:trackt/core/errors/failures.dart';
import 'package:trackt/core/utilities/pair.dart';
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/project/project.dart';
import 'package:trackt/features/todo/gateway/project_repo.dart';


@named
@LazySingleton(as: UseCase<Project, Pair<Project, User>>)
class CreateProject implements UseCase<Project, Pair<Project, User>> {
  final ProjectRepo projectRepo;

  CreateProject(this.projectRepo);

  @override
  Future<Either<Failure, Project>> call(Pair<Project, User> params) async {
    return await projectRepo.createProject(
        project: params.first, user: params.second);
  }
}