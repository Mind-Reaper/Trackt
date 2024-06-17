import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:trackt/core/config.dart';
import 'package:trackt/core/errors/exceptions.dart';
import 'package:trackt/core/errors/logger.dart';
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/project/project.dart';
import 'package:trackt/features/todo/external/persistence/project_store.dart';
import 'package:http/http.dart' as http;


@LazySingleton(as: ProjectStore)
class ProjectStoreImpl implements ProjectStore {
  final http.Client client;

  ProjectStoreImpl(this.client);

  @override
  Future<Project> createProject(
      {required Project project, required User user}) async {
    logger.d('Creating project: ${project.toJson()}');
    try {
      final response =
          await client.post(Uri.parse('${Config.todoBaseUrl}/projects'),
              headers: {
                'Authorization': 'Bearer ${user.accessToken}',
              },
              body: project.toJson()
                ..remove('id')
                ..remove('order')
                ..remove('url'));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Project.fromJson(json);
      } else {
        throw ServerException(
            'Code ${response.statusCode}: Failed to create project');
      }
    } catch (e) {
      logger.d(e.toString());
      throw ServerException('Failed to create project');
    }
  }

  @override
  Future<List<Project>> getProjects({required User user}) async  {
    try {
      logger.d('Fetching projects');
      final response = await client.get(
          Uri.parse('${Config.todoBaseUrl}/projects'),
          headers: {
            'Authorization': 'Bearer ${user.accessToken}',
          });

      if (response.statusCode == 200) {
        final json = List<Map<String, dynamic>>.from(jsonDecode(response.body));

        //remove json where is_inbox_project is true
        json.removeWhere((item) => item['is_inbox_project'] == true);


        return json.map((e) => Project.fromJson(e)).toList();
      } else {
        throw ServerException(
            'Code ${response.statusCode}: Failed to get projects');
      }
    } catch (e) {
      logger.d(e.toString());
      throw ServerException('Failed to get projects');
    }

  }
}
