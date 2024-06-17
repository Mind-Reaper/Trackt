
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/comment/comment.dart';


abstract class CommentStore {
  Future<Comment> createComment({required Comment comment, required User user});
  Future<List<Comment>> getCommentsByTaskId(
      {required String taskId, required User user});
  Future<String> deleteComment({required String id, required User user});
}
