import 'package:dartz/dartz.dart';
import 'package:trackt/core/errors/failures.dart';
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/comment/comment.dart';

abstract class CommentRepo {
  Future<Either<Failure, Comment>> createComment(
      {required Comment comment, required User user});
  Future<Either<Failure, String>> deleteComment(
      {required String id, required User user});
  Future<Either<Failure, List<Comment>>> getCommentsByTaskId(
      {required String taskId, required User user});

}