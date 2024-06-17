import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trackt/core/errors/failures.dart';
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/comment/comment.dart';
import 'package:trackt/features/todo/external/persistence/comment_store.dart';
import 'package:trackt/features/todo/gateway/comment_repo.dart';


@LazySingleton(as: CommentRepo)
class CommentRepoImpl implements CommentRepo {
  final CommentStore commentStore;

  CommentRepoImpl(this.commentStore);

  @override
  Future<Either<Failure, Comment>> createComment(
      {required Comment comment, required User user}) async {
    try {
      final createdComment =
          await commentStore.createComment(comment: comment, user: user);
      return Right(createdComment);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteComment(
      {required String id, required User user}) async {
    try {
      final deletedCommentId =
          await commentStore.deleteComment(id: id, user: user);
      return Right(deletedCommentId);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Comment>>> getCommentsByTaskId(
      {required String taskId, required User user}) async {
    try {
      final comments =
          await commentStore.getCommentsByTaskId(taskId: taskId, user: user);
      return Right(comments);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
