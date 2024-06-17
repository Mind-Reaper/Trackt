import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trackt/core/common/usecase.dart';
import 'package:trackt/core/errors/failures.dart';
import 'package:trackt/core/utilities/pair.dart';
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/comment/comment.dart';
import 'package:trackt/features/todo/gateway/comment_repo.dart';


@named
@LazySingleton(as: UseCase<List<Comment>, Pair<String, User>>)
class GetCommentsByTaskId
    implements UseCase<List<Comment>, Pair<String, User>> {
  final CommentRepo commentRepo;

  GetCommentsByTaskId(this.commentRepo);

  @override
  Future<Either<Failure, List<Comment>>> call(Pair<String, User> params) {
    return commentRepo.getCommentsByTaskId(
        taskId: params.first, user: params.second);
  }
}
