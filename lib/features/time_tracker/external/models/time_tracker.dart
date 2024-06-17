import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trackt/core/converters/date_time_string_converter.dart';
import 'package:uuid/uuid.dart';

part 'time_tracker.freezed.dart';
part 'time_tracker.g.dart';

@unfreezed
class TimeTracker with _$TimeTracker {
  factory TimeTracker({
    required final String id,
    required final String taskId,
    @DateTimeConverter() required final DateTime startTime,
    @NullableDateTimeConverter() DateTime? endTime,
    @Default('') final String description,
  }) = _TimeTracker;

  const TimeTracker._();

  factory TimeTracker.fromJson(Map<String, dynamic> json) =>
      _$TimeTrackerFromJson(json);

  factory TimeTracker.start(String taskId, {String? description}) =>
      TimeTracker(
        id: const Uuid().v4(),
        taskId: taskId,
        startTime: DateTime.now(),
        description: description ?? '',
      );

  void stop() {
    endTime = DateTime.now();
  }

  factory TimeTracker.empty() => TimeTracker(
        id: '',
        taskId: '',
        startTime: DateTime.now(),
        endTime: null,
        description: '',
      );

  bool get isRunning => endTime == null && id.isNotEmpty;

  bool get isEmpty => id.isEmpty;

  Duration? get elapsed => endTime?.difference(startTime);
}
