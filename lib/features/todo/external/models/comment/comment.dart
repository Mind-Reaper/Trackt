
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trackt/core/converters/date_time_string_converter.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Comment({
    @Default('') String id,
    required String taskId,
    required String content,
    @DateTimeConverter() required DateTime postedAt,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
}