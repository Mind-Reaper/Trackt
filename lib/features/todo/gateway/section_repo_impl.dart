import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trackt/core/errors/exceptions.dart';
import 'package:trackt/core/errors/failures.dart';
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/section/section.dart';
import 'package:trackt/features/todo/external/persistence/section_store.dart';
import 'package:trackt/features/todo/gateway/section_repo.dart';


@LazySingleton(as: SectionRepo)
class SectionRepoImpl implements SectionRepo {
  final SectionStore sectionStore;

  SectionRepoImpl(this.sectionStore);

  @override
  Future<Either<Failure, Section>> createSection(
      {required Section section, required User user}) async {
    try {
      final createdSection =
          await sectionStore.createSection(section: section, user: user);
      return Right(createdSection);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Section>>> getSectionsByProjectId(
      {required String projectId, required User user}) async {
    try {
      final sections = await sectionStore.getSectionsByProjectId(
          projectId: projectId, user: user);
      return Right(sections);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
