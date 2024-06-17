import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:trackt/core/common/usecase.dart';
import 'package:trackt/features/time_tracker/domain/usecases/get_time_trackers.dart';
import 'package:trackt/features/time_tracker/domain/usecases/get_time_trackers_by_task_id.dart';
import 'package:trackt/features/time_tracker/domain/usecases/start_tracking.dart';
import 'package:trackt/features/time_tracker/domain/usecases/stop_tracking.dart';
import 'package:trackt/features/time_tracker/external/models/time_tracker.dart';

class TrackerState {
  final TimeTracker currentTracker;
  final List<TimeTracker> trackers;
  final Timer? timer;
  final Duration elapsed;

  TrackerState(
      {required this.currentTracker,
      this.trackers = const [],
      this.timer,
      this.elapsed = const Duration()});

  TrackerState copyWith({
    TimeTracker? currentTracker,
    List<TimeTracker>? trackers,
    Timer? timer,
    Duration? elapsed,
  }) {
    return TrackerState(
      currentTracker: currentTracker ?? this.currentTracker,
      trackers: trackers ?? this.trackers,
      timer: timer ?? this.timer,
      elapsed: elapsed ?? this.elapsed,
    );
  }
}

@injectable
class TrackerController extends StateNotifier<TrackerState> {
  TrackerController(
      @Named.from(GetTimeTrackers) this.getTimeTrackersUseCase,
      @Named.from(StartTracking) this.startTrackingUseCase,
      @Named.from(StopTracking) this.stopTrackingUseCase,
      @Named.from(GetTimeTrackersByTaskId) this.getTimeTrackersByTaskIdUseCase)
      : super(TrackerState(currentTracker: TimeTracker.empty())) {
    //get timers and load any running one into state
    getTimeTrackers().then((value) {
      final running = state.trackers.firstWhere(
          (element) => element.endTime == null,
          orElse: () => TimeTracker.empty());
      if (!running.isEmpty) {
        state = state.copyWith(currentTracker: running);
        state = state.copyWith(
            timer: Timer.periodic(const Duration(seconds: 1), (timer) {
          state = state.copyWith(
              elapsed:
                  DateTime.now().difference(state.currentTracker.startTime));
        }));
      }
    });
  }

  final UseCase<List<TimeTracker>, NoParams> getTimeTrackersUseCase;
  final UseCase<DateTime, TimeTracker> startTrackingUseCase;
  final UseCase<DateTime, TimeTracker> stopTrackingUseCase;
  final UseCase<List<TimeTracker>, String> getTimeTrackersByTaskIdUseCase;

  Future<void> getTimeTrackers() async {
    final result = await getTimeTrackersUseCase(NoParams());
    result.fold((l) => null, (r) {
      state = state.copyWith(trackers: r);
    });
  }

  Future<void> startTracking(String id) async {
    if (!state.currentTracker.isEmpty) {
      await stopTracking(state.currentTracker.id);
    }
    state = state.copyWith(
        currentTracker: TimeTracker.start(id),
        timer: Timer.periodic(const Duration(seconds: 1), (timer) {
          state = state.copyWith(
              elapsed:
                  DateTime.now().difference(state.currentTracker.startTime));
        }));

    final result = await startTrackingUseCase(state.currentTracker);
  }

  Future<void> stopTracking(String id) async {
    if (!state.currentTracker.isEmpty) {
      state.timer?.cancel();
      state.currentTracker.stop();
      final result = await stopTrackingUseCase(state.currentTracker);
      state = state.copyWith(currentTracker: TimeTracker.empty());
      state = state.copyWith(elapsed: const Duration());
      getTimeTrackers();
    }
  }

  Future<void> getTimeTrackersByTaskId(String taskId) async {
    final result = await getTimeTrackersByTaskIdUseCase(taskId);
    result.fold((l) => null, (r) {
      state = state.copyWith(trackers: r);
    });
  }
}
