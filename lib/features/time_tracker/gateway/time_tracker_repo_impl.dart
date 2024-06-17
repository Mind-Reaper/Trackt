import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trackt/core/errors/exceptions.dart';
import 'package:trackt/core/errors/failures.dart';
import 'package:trackt/features/time_tracker/external/models/time_tracker.dart';
import 'package:trackt/features/time_tracker/external/persistence/time_tracker_store.dart';
import 'package:trackt/features/time_tracker/gateway/time_tracker_repo.dart';

@LazySingleton(as: TimeTrackerRepo)
class TimeTrackerRepoImpl implements TimeTrackerRepo {
  final TimeTrackerStore timeTrackerStore;

  TimeTrackerRepoImpl(this.timeTrackerStore);

  @override
  Future<Either<Failure, List<TimeTracker>>> getTimeTrackersByTaskId(
      String taskId) async {
    try {
      final timeTrackers =
          await timeTrackerStore.getTimeTrackersByTaskId(taskId);
      return Right(timeTrackers);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, DateTime>> startTracking(
      TimeTracker timeTracker) async {
    try {
      final startTime = await timeTrackerStore.startTracking(timeTracker);
      return Right(startTime);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, DateTime>> stopTracking(
      TimeTracker timeTracker) async {
    try {
      final endTime = await timeTrackerStore.stopTracking(timeTracker);
      return Right(endTime);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<TimeTracker>>> getTimeTrackers() async {
    try {
      final timeTrackers = await timeTrackerStore.getTimeTrackers();
      return Right(timeTrackers);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
