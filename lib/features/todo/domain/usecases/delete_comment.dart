import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trackt/core/common/usecase.dart';
import 'package:trackt/core/errors/failures.dart';
import 'package:trackt/core/utilities/pair.dart';
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/gateway/comment_repo.dart';


@named
@LazySingleton(as: UseCase<String, Pair<String, User>>)
class DeleteComment implements UseCase<String, Pair<String, User>> {
  final CommentRepo commentRepo;

  DeleteComment(this.commentRepo);

  @override
  Future<Either<Failure, String>> call(Pair<String, User> params) async {
    return await commentRepo.deleteComment(
        id: params.first, user: params.second);
  }
}
