// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      id: json['id'] as String? ?? '',
      taskId: json['task_id'] as String,
      content: json['content'] as String,
      postedAt: const DateTimeConverter().fromJson(json['posted_at'] as String),
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task_id': instance.taskId,
      'content': instance.content,
      'posted_at': const DateTimeConverter().toJson(instance.postedAt),
    };
