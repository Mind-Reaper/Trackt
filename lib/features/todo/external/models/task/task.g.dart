// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      id: json['id'] as String? ?? '',
      projectId: json['project_id'] as String,
      sectionId: json['section_id'] as String,
      content: json['content'] as String,
      description: json['description'] as String,
      order: (json['order'] as num).toInt(),
      createdAt:
          const DateTimeConverter().fromJson(json['created_at'] as String),
      url: json['url'] as String,
      commentCount: (json['comment_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'project_id': instance.projectId,
      'section_id': instance.sectionId,
      'content': instance.content,
      'description': instance.description,
      'order': instance.order,
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
      'url': instance.url,
      'comment_count': instance.commentCount,
    };
