import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trackt/core/common/usecase.dart';
import 'package:trackt/core/errors/failures.dart';
import 'package:trackt/core/utilities/pair.dart';
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/section/section.dart';
import 'package:trackt/features/todo/gateway/section_repo.dart';

@named
@LazySingleton(as: UseCase<List<Section>, Pair<String, User>>)
class GetSectionsByProjectId
    implements UseCase<List<Section>, Pair<String, User>> {
  final SectionRepo sectionRepo;

  GetSectionsByProjectId(this.sectionRepo);

  @override
  Future<Either<Failure, List<Section>>> call(Pair<String, User> params) {
    return sectionRepo.getSectionsByProjectId(
        projectId: params.first, user: params.second);
  }
}
