import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trackt/core/common/usecase.dart';
import 'package:trackt/core/errors/failures.dart';
import 'package:trackt/core/utilities/pair.dart';
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/section/section.dart';
import 'package:trackt/features/todo/gateway/section_repo.dart';


@named
@LazySingleton(as: UseCase<Section, Pair<Section, User>>)
class CreateSection implements UseCase<Section, Pair<Section, User>> {
  final SectionRepo sectionRepo;

  CreateSection(this.sectionRepo);

  @override
  Future<Either<Failure, Section>> call(Pair<Section, User> params) async {
    return await sectionRepo.createSection(
        section: params.first, user: params.second);
  }
}
