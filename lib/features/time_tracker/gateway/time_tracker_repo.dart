import 'package:dartz/dartz.dart';
import 'package:trackt/core/errors/failures.dart';
import 'package:trackt/features/time_tracker/external/models/time_tracker.dart';

abstract class TimeTrackerRepo {
  Future<Either<Failure, List<TimeTracker>>> getTimeTrackersByTaskId(String taskId);
  Future<Either<Failure, DateTime>> startTracking(TimeTracker timeTracker);
  Future<Either<Failure, DateTime>> stopTracking(TimeTracker timeTracker);
  Future<Either<Failure, List<TimeTracker>>> getTimeTrackers();

}
