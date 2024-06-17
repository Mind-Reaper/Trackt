// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_tracker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeTrackerImpl _$$TimeTrackerImplFromJson(Map<String, dynamic> json) =>
    _$TimeTrackerImpl(
      id: json['id'] as String,
      taskId: json['taskId'] as String,
      startTime:
          const DateTimeConverter().fromJson(json['startTime'] as String),
      endTime: const NullableDateTimeConverter()
          .fromJson(json['endTime'] as String?),
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$$TimeTrackerImplToJson(_$TimeTrackerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'taskId': instance.taskId,
      'startTime': const DateTimeConverter().toJson(instance.startTime),
      'endTime': const NullableDateTimeConverter().toJson(instance.endTime),
      'description': instance.description,
    };
