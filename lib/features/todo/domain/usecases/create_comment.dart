import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trackt/core/common/usecase.dart';
import 'package:trackt/core/errors/failures.dart';
import 'package:trackt/core/utilities/pair.dart';
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/comment/comment.dart';
import 'package:trackt/features/todo/gateway/comment_repo.dart';


@named
@LazySingleton(as: UseCase<Comment, Pair<Comment, User>>)
class CreateComment implements UseCase<Comment, Pair<Comment, User>> {
  final CommentRepo commentRepo;

  CreateComment(this.commentRepo);

  @override
  Future<Either<Failure, Comment>> call(Pair<Comment, User> params) async {
    return await commentRepo.createComment(
        comment: params.first, user: params.second);
  }
}
