import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trackt/core/converters/date_time_string_converter.dart';
import 'package:trackt/shared/color/color_generator.dart';

part 'task.g.dart';
part 'task.freezed.dart';

@freezed
class Task with _$Task {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Task({
    @Default('') String id,
    required String projectId,
    required String sectionId,
    required String content,
    required String description,
    required int order,
    @DateTimeConverter() required DateTime createdAt,
    required String url,
    @Default(0) int commentCount,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
