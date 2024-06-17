import 'package:dartz/dartz.dart';
import 'package:trackt/core/errors/failures.dart';
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/section/section.dart';

abstract class SectionRepo {
  Future<Either<Failure, Section>> createSection(
      {required Section section, required User user});
  Future<Either<Failure, List<Section>>> getSectionsByProjectId(
      {required String projectId, required User user});
}
