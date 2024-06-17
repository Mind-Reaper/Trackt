// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_tracker.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TimeTracker _$TimeTrackerFromJson(Map<String, dynamic> json) {
  return _TimeTracker.fromJson(json);
}

/// @nodoc
mixin _$TimeTracker {
  String get id => throw _privateConstructorUsedError;
  String get taskId => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get startTime => throw _privateConstructorUsedError;
  @NullableDateTimeConverter()
  DateTime? get endTime => throw _privateConstructorUsedError;
  @NullableDateTimeConverter()
  set endTime(DateTime? value) => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimeTrackerCopyWith<TimeTracker> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeTrackerCopyWith<$Res> {
  factory $TimeTrackerCopyWith(
          TimeTracker value, $Res Function(TimeTracker) then) =
      _$TimeTrackerCopyWithImpl<$Res, TimeTracker>;
  @useResult
  $Res call(
      {String id,
      String taskId,
      @DateTimeConverter() DateTime startTime,
      @NullableDateTimeConverter() DateTime? endTime,
      String description});
}

/// @nodoc
class _$TimeTrackerCopyWithImpl<$Res, $Val extends TimeTracker>
    implements $TimeTrackerCopyWith<$Res> {
  _$TimeTrackerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? taskId = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeTrackerImplCopyWith<$Res>
    implements $TimeTrackerCopyWith<$Res> {
  factory _$$TimeTrackerImplCopyWith(
          _$TimeTrackerImpl value, $Res Function(_$TimeTrackerImpl) then) =
      __$$TimeTrackerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String taskId,
      @DateTimeConverter() DateTime startTime,
      @NullableDateTimeConverter() DateTime? endTime,
      String description});
}

/// @nodoc
class __$$TimeTrackerImplCopyWithImpl<$Res>
    extends _$TimeTrackerCopyWithImpl<$Res, _$TimeTrackerImpl>
    implements _$$TimeTrackerImplCopyWith<$Res> {
  __$$TimeTrackerImplCopyWithImpl(
      _$TimeTrackerImpl _value, $Res Function(_$TimeTrackerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? taskId = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? description = null,
  }) {
    return _then(_$TimeTrackerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeTrackerImpl extends _TimeTracker {
  _$TimeTrackerImpl(
      {required this.id,
      required this.taskId,
      @DateTimeConverter() required this.startTime,
      @NullableDateTimeConverter() this.endTime,
      this.description = ''})
      : super._();

  factory _$TimeTrackerImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeTrackerImplFromJson(json);

  @override
  final String id;
  @override
  final String taskId;
  @override
  @DateTimeConverter()
  final DateTime startTime;
  @override
  @NullableDateTimeConverter()
  DateTime? endTime;
  @override
  @JsonKey()
  final String description;

  @override
  String toString() {
    return 'TimeTracker(id: $id, taskId: $taskId, startTime: $startTime, endTime: $endTime, description: $description)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeTrackerImplCopyWith<_$TimeTrackerImpl> get copyWith =>
      __$$TimeTrackerImplCopyWithImpl<_$TimeTrackerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeTrackerImplToJson(
      this,
    );
  }
}

abstract class _TimeTracker extends TimeTracker {
  factory _TimeTracker(
      {required final String id,
      required final String taskId,
      @DateTimeConverter() required final DateTime startTime,
      @NullableDateTimeConverter() DateTime? endTime,
      final String description}) = _$TimeTrackerImpl;
  _TimeTracker._() : super._();

  factory _TimeTracker.fromJson(Map<String, dynamic> json) =
      _$TimeTrackerImpl.fromJson;

  @override
  String get id;
  @override
  String get taskId;
  @override
  @DateTimeConverter()
  DateTime get startTime;
  @override
  @NullableDateTimeConverter()
  DateTime? get endTime;
  @NullableDateTimeConverter()
  set endTime(DateTime? value);
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$TimeTrackerImplCopyWith<_$TimeTrackerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
