import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:trackt/core/config.dart';
import 'package:trackt/core/errors/exceptions.dart';
import 'package:trackt/core/errors/logger.dart';
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/section/section.dart';
import 'package:trackt/features/todo/external/persistence/section_store.dart';
import 'package:http/http.dart' as http;

@LazySingleton(as: SectionStore)
class SectionStoreImpl implements SectionStore {
  final http.Client client;

  SectionStoreImpl(this.client);

  @override
  Future<Section> createSection(
      {required Section section, required User user}) async {
    try {
      final response =
          await client.post(Uri.parse('${Config.todoBaseUrl}/sections'),
              headers: {
                'Authorization': 'Bearer ${user.accessToken}',
              },
              body: section.toJson()..remove('id'));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Section.fromJson(json);
      } else {
        throw ServerException(
            'Code ${response.statusCode}: Failed to create section');
      }
    } catch (e) {
      logger.d(e.toString());
      throw ServerException('Failed to create section');
    }
  }

  @override
  Future<List<Section>> getSectionsByProjectId(
      {required String projectId, required User user}) async {
    try {
      final response = await client.get(
          Uri.parse('${Config.todoBaseUrl}/sections?project_id=$projectId'),
          headers: {
            'Authorization': 'Bearer ${user.accessToken}',
          });

      if (response.statusCode == 200) {
        final json = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        json.removeWhere((e) => !SectionName.values
            .map((sectionName) => sectionName.name)
            .contains(e['name']));
        return json.map((e) => Section.fromJson(e)).toList();
      } else {
        throw ServerException(
            'Code ${response.statusCode}: Failed to get sections');
      }
    } catch (e) {
      logger.d(e.toString());
      throw ServerException('Failed to get sections');
    }
  }
}
