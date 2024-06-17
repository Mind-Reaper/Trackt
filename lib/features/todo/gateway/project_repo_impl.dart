import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trackt/core/errors/exceptions.dart';
import 'package:trackt/core/errors/failures.dart';
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/project/project.dart';
import 'package:trackt/features/todo/external/persistence/project_store.dart';
import 'package:trackt/features/todo/gateway/project_repo.dart';


@LazySingleton(as: ProjectRepo)
class ProjectRepoImpl implements ProjectRepo {
  final ProjectStore projectStore;

  ProjectRepoImpl(this.projectStore);

  @override
  Future<Either<Failure, Project>> createProject(
      {required Project project, required User user}) async {
    try {
      final createdProject =
          await projectStore.createProject(project: project, user: user);
      return Right(createdProject);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Project>>> getProjects(
      {required User user}) async {
    try {
      final projects = await projectStore.getProjects(user: user);
      return Right(projects);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
