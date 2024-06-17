import 'package:trackt/features/time_tracker/external/models/time_tracker.dart';

abstract class TimeTrackerStore {
  Future<List<TimeTracker>> getTimeTrackersByTaskId(String taskId);
  Future<List<TimeTracker>> getTimeTrackers();
  Future<DateTime> startTracking(TimeTracker timeTracker);
  Future<DateTime> stopTracking(TimeTracker timeTracker);

}
