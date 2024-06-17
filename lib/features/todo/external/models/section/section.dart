

import 'package:freezed_annotation/freezed_annotation.dart';

part 'section.freezed.dart';
part 'section.g.dart';

enum SectionName {
  backlog,
  todo,
  inProgress,
  done;

  String get description {
    switch (this) {
      case SectionName.backlog:
        return 'Backlog';
      case SectionName.todo:
        return 'To Do';
      case SectionName.inProgress:
        return 'In Progress';
      case SectionName.done:
        return 'Done';
    }
  }
}

@freezed
class Section with _$Section {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Section({
    @Default('') String id,
    required String projectId,
    required SectionName name,
  }) = _Section;

  const Section._();

  factory Section.fromJson(Map<String, dynamic> json) => _$SectionFromJson(json);

  int get order => name.index;
}