import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trackt/core/common/usecase.dart';
import 'package:trackt/core/errors/failures.dart';
import 'package:trackt/features/time_tracker/external/models/time_tracker.dart';
import 'package:trackt/features/time_tracker/gateway/time_tracker_repo.dart';

@named
@LazySingleton(as: UseCase<List<TimeTracker>, NoParams>)
class GetTimeTrackers implements UseCase<List<TimeTracker>, NoParams> {
  final TimeTrackerRepo timeTrackerRepo;

  GetTimeTrackers(this.timeTrackerRepo);

  @override
  Future<Either<Failure, List<TimeTracker>>> call(NoParams params) {
    return timeTrackerRepo.getTimeTrackers();
  }
}
