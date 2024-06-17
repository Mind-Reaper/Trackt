import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trackt/core/common/usecase.dart';
import 'package:trackt/core/errors/failures.dart';
import 'package:trackt/features/time_tracker/external/models/time_tracker.dart';
import 'package:trackt/features/time_tracker/gateway/time_tracker_repo.dart';

@named
@LazySingleton(as: UseCase<DateTime, TimeTracker>)
class StopTracking implements UseCase<DateTime, TimeTracker> {
  final TimeTrackerRepo timeTrackerRepo;

  StopTracking(this.timeTrackerRepo);

  @override
  Future<Either<Failure, DateTime>> call(TimeTracker params) {
    return timeTrackerRepo.stopTracking(params);
  }
}
