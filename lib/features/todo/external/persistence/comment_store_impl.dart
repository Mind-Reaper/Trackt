import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:trackt/core/config.dart';
import 'package:trackt/core/errors/exceptions.dart';
import 'package:trackt/core/errors/logger.dart';
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/comment/comment.dart';
import 'package:trackt/features/todo/external/persistence/comment_store.dart';

@LazySingleton(as: CommentStore)
class CommentStoreImpl implements CommentStore {
  final http.Client client;

  CommentStoreImpl(this.client);

  @override
  Future<Comment> createComment(
      {required Comment comment, required User user}) async {
    try {
      final response =
          await client.post(Uri.parse('${Config.todoBaseUrl}/comments'),
              headers: {
                'Authorization': 'Bearer ${user.accessToken}',
              },
              body: comment.toJson()
                ..remove('id')
                ..remove('posted_at'));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Comment.fromJson(json);
      } else {
        throw ServerException(
            'Code ${response.statusCode}: Failed to create comment');
      }
    } catch (e) {
      logger.d(e.toString());
      throw ServerException('Failed to create comment');
    }
  }

  @override
  Future<List<Comment>> getCommentsByTaskId(
      {required String taskId, required User user}) async {
    try {
      final response = await client.get(
          Uri.parse('${Config.todoBaseUrl}/comments?task_id=$taskId'),
          headers: {
            'Authorization': 'Bearer ${user.accessToken}',
          });

      if (response.statusCode == 200) {
        final json = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        return json.map((e) => Comment.fromJson(e)).toList();
      } else {
        throw ServerException(
            'Code ${response.statusCode}: Failed to get comments');
      }
    } catch (e) {
      logger.d(e.toString());
      throw ServerException('Failed to get comments');
    }
  }

  @override
  Future<String> deleteComment({required String id, required User user}) async {
    try {
      final response = await client
          .delete(Uri.parse('${Config.todoBaseUrl}/comments/$id'), headers: {
        'Authorization': 'Bearer ${user.accessToken}',
      });
      if (response.statusCode != 204) {
        throw ServerException(
            'Code ${response.statusCode}: Failed to delete comment');
      }
      return id;
    } catch (e) {
      logger.d(e.toString());
      throw ServerException('Failed to delete comment');
    }
  }
}
