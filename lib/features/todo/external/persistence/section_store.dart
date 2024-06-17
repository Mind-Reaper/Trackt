import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/features/todo/external/models/section/section.dart';



abstract class SectionStore {
  Future<Section> createSection({required Section section, required User user});
  Future<List<Section>> getSectionsByProjectId(
      {required String projectId, required User user});
}
