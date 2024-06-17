import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackt/core/errors/exceptions.dart';
import 'package:trackt/features/time_tracker/external/models/time_tracker.dart';
import 'package:trackt/features/time_tracker/external/persistence/time_tracker_store.dart';

@LazySingleton(as: TimeTrackerStore)
class TimeTrackerStoreImpl implements TimeTrackerStore {
  final SharedPreferences sharedPreferences;

  TimeTrackerStoreImpl(this.sharedPreferences);

  @override
  Future<List<TimeTracker>> getTimeTrackersByTaskId(String taskId) async {
    try {
      final trackersJson = sharedPreferences.getString('time_trackers') ?? '[]';
      final trackersList =
          List<Map<String, dynamic>>.from(jsonDecode(trackersJson));
      return trackersList
          .where((tracker) => tracker['taskId'] == taskId)
          .map((tracker) => TimeTracker.fromJson(tracker))
          .toList();
    } catch (e) {
      throw ServerException('Error getting time trackers');
    }
  }

  @override
  Future<DateTime> startTracking(TimeTracker timeTracker) async {
    try {
      final trackers = await getTimeTrackers();
      trackers.add(timeTracker);
      sharedPreferences.setString(
        'time_trackers',
        jsonEncode(trackers.map((tracker) => tracker.toJson()).toList()),
      );
      return timeTracker.startTime;
    } catch (e) {
      throw ServerException('Error starting time tracker');
    }
  }

  @override
  Future<DateTime> stopTracking(TimeTracker timeTracker) async {
    try {
      final trackers = await getTimeTrackers();
      final index =
          trackers.indexWhere((tracker) => tracker.id == timeTracker.id);
      if (index == -1) {
        throw ServerException('Time tracker not found');
      }
      trackers[index].stop();
      sharedPreferences.setString(
        'time_trackers',
        jsonEncode(trackers.map((tracker) => tracker.toJson()).toList()),
      );
      return timeTracker.endTime!;
    } catch (e) {
      throw ServerException('Error stopping time tracker');
    }
  }

  @override
  Future<List<TimeTracker>> getTimeTrackers() async {
    try {
      final trackersJson = sharedPreferences.getString('time_trackers') ?? '[]';

      final trackersList =
          List<Map<String, dynamic>>.from(jsonDecode(trackersJson));
      return trackersList
          .map((tracker) => TimeTracker.fromJson(tracker))
          .toList();
    } catch (e) {
      throw ServerException('Error getting time trackers');
    }
  }
}
