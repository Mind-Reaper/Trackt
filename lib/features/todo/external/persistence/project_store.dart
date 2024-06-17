import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/project/project.dart';

abstract class ProjectStore {
  Future<Project> createProject({required Project project, required User user});
  Future<List<Project>> getProjects({required User user});
}
