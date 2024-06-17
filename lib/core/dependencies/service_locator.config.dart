// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

import '../../features/time_tracker/domain/usecases/get_time_trackers.dart'
    as _i22;
import '../../features/time_tracker/domain/usecases/get_time_trackers_by_task_id.dart'
    as _i29;
import '../../features/time_tracker/domain/usecases/start_tracking.dart'
    as _i21;
import '../../features/time_tracker/domain/usecases/stop_tracking.dart' as _i30;
import '../../features/time_tracker/external/models/time_tracker.dart' as _i20;
import '../../features/time_tracker/external/persistence/time_tracker_store.dart'
    as _i9;
import '../../features/time_tracker/external/persistence/time_tracker_store_impl.dart'
    as _i10;
import '../../features/time_tracker/external/presentation/controllers/tracker_controller.dart'
    as _i41;
import '../../features/time_tracker/gateway/time_tracker_repo.dart' as _i15;
import '../../features/time_tracker/gateway/time_tracker_repo_impl.dart'
    as _i16;
import '../../features/todo/domain/usecases/create_comment.dart' as _i42;
import '../../features/todo/domain/usecases/create_project.dart' as _i35;
import '../../features/todo/domain/usecases/create_section.dart' as _i31;
import '../../features/todo/domain/usecases/create_task.dart' as _i48;
import '../../features/todo/domain/usecases/delete_comment.dart' as _i38;
import '../../features/todo/domain/usecases/delete_task.dart' as _i43;
import '../../features/todo/domain/usecases/get_comments_by_task_id.dart'
    as _i40;
import '../../features/todo/domain/usecases/get_projects.dart' as _i44;
import '../../features/todo/domain/usecases/get_sections_by_project_id.dart'
    as _i26;
import '../../features/todo/domain/usecases/get_tasks_by_section_id.dart'
    as _i46;
import '../../features/todo/domain/usecases/move_task.dart' as _i47;
import '../../features/todo/domain/usecases/update_task.dart' as _i49;
import '../../features/todo/external/models/comment/comment.dart' as _i39;
import '../../features/todo/external/models/project/project.dart' as _i34;
import '../../features/todo/external/models/section/section.dart' as _i23;
import '../../features/todo/external/models/task/task.dart' as _i45;
import '../../features/todo/external/persistence/comment_store.dart' as _i7;
import '../../features/todo/external/persistence/comment_store_impl.dart'
    as _i8;
import '../../features/todo/external/persistence/project_store.dart' as _i13;
import '../../features/todo/external/persistence/project_store_impl.dart'
    as _i14;
import '../../features/todo/external/persistence/section_store.dart' as _i5;
import '../../features/todo/external/persistence/section_store_impl.dart'
    as _i6;
import '../../features/todo/external/persistence/task_store.dart' as _i11;
import '../../features/todo/external/persistence/task_store_impl.dart' as _i12;
import '../../features/todo/external/presentation/controller/project_controller.dart'
    as _i50;
import '../../features/todo/gateway/comment_repo.dart' as _i27;
import '../../features/todo/gateway/comment_repo_impl.dart' as _i28;
import '../../features/todo/gateway/project_repo.dart' as _i32;
import '../../features/todo/gateway/project_repo_impl.dart' as _i33;
import '../../features/todo/gateway/section_repo.dart' as _i17;
import '../../features/todo/gateway/section_repo_impl.dart' as _i18;
import '../../features/todo/gateway/task_repo.dart' as _i36;
import '../../features/todo/gateway/task_repo_impl.dart' as _i37;
import '../common/usecase.dart' as _i19;
import '../models/user/user.dart' as _i25;
import '../utilities/pair.dart' as _i24;
import 'register_module.dart' as _i51;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  await gh.factoryAsync<_i3.SharedPreferences>(
    () => registerModule.sharedPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i4.Client>(() => registerModule.httpClient);
  gh.lazySingleton<_i5.SectionStore>(
      () => _i6.SectionStoreImpl(gh<_i4.Client>()));
  gh.lazySingleton<_i7.CommentStore>(
      () => _i8.CommentStoreImpl(gh<_i4.Client>()));
  gh.lazySingleton<_i9.TimeTrackerStore>(
      () => _i10.TimeTrackerStoreImpl(gh<_i3.SharedPreferences>()));
  gh.lazySingleton<_i11.TaskStore>(() => _i12.TaskStoreImpl(gh<_i4.Client>()));
  gh.lazySingleton<_i13.ProjectStore>(
      () => _i14.ProjectStoreImpl(gh<_i4.Client>()));
  gh.lazySingleton<_i15.TimeTrackerRepo>(
      () => _i16.TimeTrackerRepoImpl(gh<_i9.TimeTrackerStore>()));
  gh.lazySingleton<_i17.SectionRepo>(
      () => _i18.SectionRepoImpl(gh<_i5.SectionStore>()));
  gh.lazySingleton<_i19.UseCase<DateTime, _i20.TimeTracker>>(
    () => _i21.StartTracking(gh<_i15.TimeTrackerRepo>()),
    instanceName: 'StartTracking',
  );
  gh.lazySingleton<_i19.UseCase<List<_i20.TimeTracker>, _i19.NoParams>>(
    () => _i22.GetTimeTrackers(gh<_i15.TimeTrackerRepo>()),
    instanceName: 'GetTimeTrackers',
  );
  gh.lazySingleton<
      _i19.UseCase<List<_i23.Section>, _i24.Pair<String, _i25.User>>>(
    () => _i26.GetSectionsByProjectId(gh<_i17.SectionRepo>()),
    instanceName: 'GetSectionsByProjectId',
  );
  gh.lazySingleton<_i27.CommentRepo>(
      () => _i28.CommentRepoImpl(gh<_i7.CommentStore>()));
  gh.lazySingleton<_i19.UseCase<List<_i20.TimeTracker>, String>>(
    () => _i29.GetTimeTrackersByTaskId(gh<_i15.TimeTrackerRepo>()),
    instanceName: 'GetTimeTrackersByTaskId',
  );
  gh.lazySingleton<_i19.UseCase<DateTime, _i20.TimeTracker>>(
    () => _i30.StopTracking(gh<_i15.TimeTrackerRepo>()),
    instanceName: 'StopTracking',
  );
  gh.lazySingleton<
      _i19.UseCase<_i23.Section, _i24.Pair<_i23.Section, _i25.User>>>(
    () => _i31.CreateSection(gh<_i17.SectionRepo>()),
    instanceName: 'CreateSection',
  );
  gh.lazySingleton<_i32.ProjectRepo>(
      () => _i33.ProjectRepoImpl(gh<_i13.ProjectStore>()));
  gh.lazySingleton<
      _i19.UseCase<_i34.Project, _i24.Pair<_i34.Project, _i25.User>>>(
    () => _i35.CreateProject(gh<_i32.ProjectRepo>()),
    instanceName: 'CreateProject',
  );
  gh.lazySingleton<_i36.TaskRepo>(
      () => _i37.TaskRepoImpl(gh<_i11.TaskStore>()));
  gh.lazySingleton<_i19.UseCase<String, _i24.Pair<String, _i25.User>>>(
    () => _i38.DeleteComment(gh<_i27.CommentRepo>()),
    instanceName: 'DeleteComment',
  );
  gh.lazySingleton<
      _i19.UseCase<List<_i39.Comment>, _i24.Pair<String, _i25.User>>>(
    () => _i40.GetCommentsByTaskId(gh<_i27.CommentRepo>()),
    instanceName: 'GetCommentsByTaskId',
  );
  gh.factory<_i41.TrackerController>(() => _i41.TrackerController(
        gh<_i19.UseCase<List<_i20.TimeTracker>, _i19.NoParams>>(
            instanceName: 'GetTimeTrackers'),
        gh<_i19.UseCase<DateTime, _i20.TimeTracker>>(
            instanceName: 'StartTracking'),
        gh<_i19.UseCase<DateTime, _i20.TimeTracker>>(
            instanceName: 'StopTracking'),
        gh<_i19.UseCase<List<_i20.TimeTracker>, String>>(
            instanceName: 'GetTimeTrackersByTaskId'),
      ));
  gh.lazySingleton<
      _i19.UseCase<_i39.Comment, _i24.Pair<_i39.Comment, _i25.User>>>(
    () => _i42.CreateComment(gh<_i27.CommentRepo>()),
    instanceName: 'CreateComment',
  );
  gh.lazySingleton<_i19.UseCase<String, _i24.Pair<String, _i25.User>>>(
    () => _i43.DeleteTask(gh<_i36.TaskRepo>()),
    instanceName: 'DeleteTask',
  );
  gh.lazySingleton<_i19.UseCase<List<_i34.Project>, _i25.User>>(
    () => _i44.GetProjects(gh<_i32.ProjectRepo>()),
    instanceName: 'GetProjects',
  );
  gh.lazySingleton<_i19.UseCase<List<_i45.Task>, _i24.Pair<String, _i25.User>>>(
    () => _i46.GetTasksBySectionId(gh<_i36.TaskRepo>()),
    instanceName: 'GetTasksBySectionId',
  );
  gh.lazySingleton<_i19.UseCase<_i45.Task, _i24.Pair<_i45.Task, _i25.User>>>(
    () => _i47.MoveTask(gh<_i36.TaskRepo>()),
    instanceName: 'MoveTask',
  );
  gh.lazySingleton<_i19.UseCase<_i45.Task, _i24.Pair<_i45.Task, _i25.User>>>(
    () => _i48.CreateTask(gh<_i36.TaskRepo>()),
    instanceName: 'CreateTask',
  );
  gh.lazySingleton<_i19.UseCase<_i45.Task, _i24.Pair<_i45.Task, _i25.User>>>(
    () => _i49.UpdateTask(gh<_i36.TaskRepo>()),
    instanceName: 'UpdateTask',
  );
  gh.factory<_i50.ProjectController>(() => _i50.ProjectController(
        gh<_i19.UseCase<List<_i34.Project>, _i25.User>>(
            instanceName: 'GetProjects'),
        gh<_i19.UseCase<_i34.Project, _i24.Pair<_i34.Project, _i25.User>>>(
            instanceName: 'CreateProject'),
        gh<_i19.UseCase<List<_i23.Section>, _i24.Pair<String, _i25.User>>>(
            instanceName: 'GetSectionsByProjectId'),
        gh<_i19.UseCase<_i23.Section, _i24.Pair<_i23.Section, _i25.User>>>(
            instanceName: 'CreateSection'),
        gh<_i19.UseCase<List<_i45.Task>, _i24.Pair<String, _i25.User>>>(
            instanceName: 'GetTasksBySectionId'),
        gh<_i19.UseCase<_i45.Task, _i24.Pair<_i45.Task, _i25.User>>>(
            instanceName: 'CreateTask'),
        gh<_i19.UseCase<_i45.Task, _i24.Pair<_i45.Task, _i25.User>>>(
            instanceName: 'UpdateTask'),
        gh<_i19.UseCase<_i45.Task, _i24.Pair<_i45.Task, _i25.User>>>(
            instanceName: 'MoveTask'),
        gh<_i19.UseCase<String, _i24.Pair<String, _i25.User>>>(
            instanceName: 'DeleteTask'),
        gh<_i19.UseCase<List<_i39.Comment>, _i24.Pair<String, _i25.User>>>(
            instanceName: 'GetCommentsByTaskId'),
        gh<_i19.UseCase<_i39.Comment, _i24.Pair<_i39.Comment, _i25.User>>>(
            instanceName: 'CreateComment'),
        gh<_i19.UseCase<String, _i24.Pair<String, _i25.User>>>(
            instanceName: 'DeleteComment'),
      ));
  return getIt;
}

class _$RegisterModule extends _i51.RegisterModule {}
