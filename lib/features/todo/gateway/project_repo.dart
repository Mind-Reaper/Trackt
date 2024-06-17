import 'package:dartz/dartz.dart';
import 'package:trackt/core/errors/failures.dart';
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/project/project.dart';



abstract class ProjectRepo {
  Future<Either<Failure, Project>> createProject(
      {required Project project, required User user});

  Future<Either<Failure, List<Project>>> getProjects(
      {required User user});
}
