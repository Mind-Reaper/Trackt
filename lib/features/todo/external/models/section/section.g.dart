// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SectionImpl _$$SectionImplFromJson(Map<String, dynamic> json) =>
    _$SectionImpl(
      id: json['id'] as String? ?? '',
      projectId: json['project_id'] as String,
      name: $enumDecode(_$SectionNameEnumMap, json['name']),
    );

Map<String, dynamic> _$$SectionImplToJson(_$SectionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'project_id': instance.projectId,
      'name': _$SectionNameEnumMap[instance.name]!,
    };

const _$SectionNameEnumMap = {
  SectionName.backlog: 'backlog',
  SectionName.todo: 'todo',
  SectionName.inProgress: 'inProgress',
  SectionName.done: 'done',
};
