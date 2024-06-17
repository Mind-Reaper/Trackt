import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:trackt/core/config.dart';
import 'package:trackt/core/errors/exceptions.dart';
import 'package:trackt/core/errors/logger.dart';
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/task/task.dart';
import 'package:trackt/features/todo/external/persistence/task_store.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

@LazySingleton(as: TaskStore)
class TaskStoreImpl implements TaskStore {
  final http.Client client;

  TaskStoreImpl(this.client);

  @override
  Future<Task> createTask({required Task task, required User user}) async {
    try {
      final response = await client.post(
        Uri.parse('${Config.todoBaseUrl}/tasks'),
        headers: {
          'Authorization': 'Bearer ${user.accessToken}',
        },
        body: task.toJson()
          ..remove('id')
          ..remove('order')
          ..remove('created_at')
          ..remove('url')
          ..remove('comment_count'),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Task.fromJson(json);
      } else {
        throw ServerException(
            'Code ${response.statusCode}: Failed to create task');
      }
    } catch (e) {
      logger.d(e.toString());
      throw ServerException('Failed to create task');
    }
  }

  @override
  Future<String> deleteTask({required String id, required User user}) async {
    try {
      final response = await client.delete(
        Uri.parse('${Config.todoBaseUrl}/tasks/$id'),
        headers: {
          'Authorization': 'Bearer ${user.accessToken}',
        },
      );
      if (response.statusCode != 204) {
        throw ServerException(
            'Code ${response.statusCode}: Failed to delete task');
      }
      return id;
    } catch (e) {
      logger.d(e.toString());
      throw ServerException('Failed to delete task');
    }
  }

  @override
  Future<List<Task>> getTasksBySectionId(
      {required String sectionId, required User user}) async {
    try {
      final response = await client.get(
          Uri.parse('${Config.todoBaseUrl}/tasks?section_id=$sectionId'),
          headers: {
            'Authorization': 'Bearer ${user.accessToken}',
          });

      if (response.statusCode == 200) {
        final json = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        return json.map((e) => Task.fromJson(e)).toList();
      } else {
        throw ServerException(
            'Code ${response.statusCode}: Failed to get tasks');
      }
    } catch (e) {
      logger.d(e.toString());
      throw ServerException('Failed to get tasks');
    }
  }

  @override
  Future<Task> updateTask({required Task task, required User user}) async {
    try {
      final response = await client.post(
        Uri.parse('${Config.todoBaseUrl}/tasks/${task.id}'),
        headers: {
          'Authorization': 'Bearer ${user.accessToken}',
        },
        body: task.toJson()
          ..remove('id')
          ..remove('created_at')
          ..remove('project_id')
          ..remove('order')
          // ..remove('section_id')
          ..remove('comment_count'),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(json);
        return Task.fromJson(json);
      } else {
        throw ServerException(
            'Code ${response.statusCode}: Failed to update task');
      }
    } catch (e) {
      logger.d(e.toString());
      throw ServerException('Failed to update task');
    }
  }

  @override
  Future<Task> moveTask({required Task task, required User user}) async {
    try {
      const String url = Config.todoSyncUrl;

      final String uniqueId = const Uuid().v4();

      final Map<String, String> headers = {
        'Authorization': 'Bearer ${user.accessToken}',
        'Content-Type': 'application/x-www-form-urlencoded',
      };

      final Map<String, dynamic> body = {
        'commands': [
          {
            'type': 'item_move',
            'uuid': uniqueId,
            'args': {
              'id': task.id,
              'section_id': task.sectionId,
              'project_id': task.projectId,
            },
          },
        ],
      };

      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        final syncToken = responseJson['sync_token'];

        final body = {
          'sync_token': '*',
          'resource_types': ['items'],
        };

        final readResponse = await http.post(
          Uri.parse(url),
          headers: headers,
          body: json.encode(body),
        );

        if (readResponse.statusCode == 200) {
          final json = jsonDecode(readResponse.body);
          print(json);
        }

        return task;
      } else {
        throw ServerException(
            'Code ${response.statusCode}: Failed to move task');
      }
    } catch (e) {
      logger.d(e.toString());
      throw ServerException('Failed to move task');
    }
  }
}
