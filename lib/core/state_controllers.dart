import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trackt/features/time_tracker/external/presentation/controllers/tracker_controller.dart';
import 'package:trackt/features/todo/external/presentation/controller/project_controller.dart';
import 'package:trackt/core/dependencies/service_locator.dart' as di;

final projectController =
    StateNotifierProvider<ProjectController, ProjectState>(
        (ref) => di.sl<ProjectController>());

final trackerController =
    StateNotifierProvider<TrackerController, TrackerState>(
        (ref) => di.sl<TrackerController>());
