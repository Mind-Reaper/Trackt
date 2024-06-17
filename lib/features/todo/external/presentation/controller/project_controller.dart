import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:trackt/core/common/usecase.dart';
import 'package:trackt/core/models/user/user.dart';
import 'package:trackt/core/utilities/pair.dart';
import 'package:trackt/features/todo/domain/usecases/create_comment.dart';
import 'package:trackt/features/todo/domain/usecases/create_project.dart';
import 'package:trackt/features/todo/domain/usecases/create_section.dart';
import 'package:trackt/features/todo/domain/usecases/create_task.dart';
import 'package:trackt/features/todo/domain/usecases/delete_comment.dart';
import 'package:trackt/features/todo/domain/usecases/delete_task.dart';
import 'package:trackt/features/todo/domain/usecases/get_comments_by_task_id.dart';
import 'package:trackt/features/todo/domain/usecases/get_projects.dart';
import 'package:trackt/features/todo/domain/usecases/get_sections_by_project_id.dart';
import 'package:trackt/features/todo/domain/usecases/get_tasks_by_section_id.dart';
import 'package:trackt/features/todo/domain/usecases/move_task.dart';
import 'package:trackt/features/todo/domain/usecases/update_task.dart';
import 'package:trackt/features/todo/external/models/comment/comment.dart';
import 'package:trackt/features/todo/external/models/project/project.dart';

import 'package:trackt/features/todo/external/models/section/section.dart';
import 'package:trackt/features/todo/external/models/task/task.dart';

class ProjectState {
  final bool loading;
  final Project? project;
  final List<Section> sections;
  final List<Task> tasks;

  ProjectState(
      {this.sections = const [],
      this.tasks = const [],
      this.loading = false,
      this.project});

  ProjectState copyWith(
      {bool? loading,
      Project? project,
      List<Section>? sections,
      List<Task>? tasks}) {
    return ProjectState(
      loading: loading ?? this.loading,
      project: project ?? this.project,
      sections: sections ?? this.sections,
      tasks: tasks ?? this.tasks,
    );
  }
}

@injectable
class ProjectController extends StateNotifier<ProjectState> {
  ProjectController(
      @Named.from(GetProjects) this.getProjectsUseCase,
      @Named.from(CreateProject) this.createProjectUseCase,
      @Named.from(GetSectionsByProjectId) this.getSectionsByProjectIdUseCase,
      @Named.from(CreateSection) this.createSectionUseCase,
      @Named.from(GetTasksBySectionId) this.getTasksBySectionIdUseCase,
      @Named.from(CreateTask) this.createTaskUseCase,
      @Named.from(UpdateTask) this.updateTaskUseCase,
      @Named.from(MoveTask) this.moveTaskUseCase,
      @Named.from(DeleteTask) this.deleteTaskUseCase,
      @Named.from(GetCommentsByTaskId) this.getCommentsByTaskIdUseCase,
      @Named.from(CreateComment) this.createCommentUseCase,
      @Named.from(DeleteComment) this.deleteCommentUseCase)
      : super(ProjectState()) {
    showLoader();
    init().then((v) {
      hideLoader();
    });
  }

  final UseCase<List<Project>, User> getProjectsUseCase;
  final UseCase<Project, Pair<Project, User>> createProjectUseCase;
  final UseCase<List<Section>, Pair<String, User>>
      getSectionsByProjectIdUseCase;
  final UseCase<Section, Pair<Section, User>> createSectionUseCase;
  final UseCase<List<Task>, Pair<String, User>> getTasksBySectionIdUseCase;
  final UseCase<Task, Pair<Task, User>> createTaskUseCase;
  final UseCase<Task, Pair<Task, User>> updateTaskUseCase;
  final UseCase<Task, Pair<Task, User>> moveTaskUseCase;
  final UseCase<String, Pair<String, User>> deleteTaskUseCase;
  final UseCase<List<Comment>, Pair<String, User>> getCommentsByTaskIdUseCase;
  final UseCase<Comment, Pair<Comment, User>> createCommentUseCase;
  final UseCase<String, Pair<String, User>> deleteCommentUseCase;

  void showLoader() {
    state = state.copyWith(loading: true);
  }

  void hideLoader() {
    state = state.copyWith(loading: false);
  }

  Future<void> init() async {
    final user = User.current();

    final result = await getProjectsUseCase.call(user);
    final projects = result.fold((l) => null, (r) => r);
    if (projects == null) {
      return;
    }
    if (projects.isEmpty) {
      const project = Project(name: 'Innoscripta', order: 0, url: '');
      final result = await createProjectUseCase.call(Pair(project, user));
      final createdProject = result.fold((l) => null, (r) => r);
      if (createdProject != null) {
        state = state.copyWith(project: createdProject);
      }
    } else {
      state = state.copyWith(project: projects.first);
    }
    await getProjectSections();
  }

  Future<void> getProjectSections() async {
    final project = state.project;
    if (project == null) {
      return;
    }
    final user = User.current();
    final result =
        await getSectionsByProjectIdUseCase.call(Pair(project.id, user));
    final sections = result.fold((l) => null, (r) => r);
    if (sections == null) {
      return;
    }
    if (sections.isEmpty || sections.length < SectionName.values.length) {
      final newSections = SectionName.values
          .where((sectionName) => !sections.any((s) => s.name == sectionName))
          .map((e) => Section(
                name: e,
                projectId: project.id,
              ))
          .toList();
      for (final section in newSections) {
        final result = await createSectionUseCase.call(Pair(section, user));
        final createdSection = result.fold((l) => null, (r) => r);
        if (createdSection != null) {
          sections.add(createdSection);
        }
      }
    }
    state = state.copyWith(sections: sections);
    await getSectionsTasks();
  }

  Future<void> getSectionsTasks() async {
    final sections = state.sections;
    if (sections.isEmpty) {
      return;
    }
    final user = User.current();
    final tasks = <Task>[];
    for (final section in sections) {
      final result =
          await getTasksBySectionIdUseCase.call(Pair(section.id, user));
      final sectionTasks = result.fold((l) => null, (r) => r);
      if (sectionTasks != null) {
        tasks.addAll(sectionTasks);
      }
    }
    state = state.copyWith(tasks: tasks);
  }

  Future<bool> createTask(Task task) async {
    final user = User.current();
    final result = await createTaskUseCase.call(Pair(task, user));
    final createdTask = result.fold((l) => null, (r) => r);
    if (createdTask != null) {
      state = state.copyWith(tasks: [...state.tasks, createdTask]);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateTask(Task task, {bool move = false}) async {
    final user = User.current();

    if (move) {
      final result = await moveTaskUseCase.call(Pair(task, user));
      final movedTask = result.fold((l) => null, (r) => r);
      if (movedTask != null) {
        final tasks = state.tasks
            .map((e) => e.id == movedTask.id ? movedTask : e)
            .toList();
        state = state.copyWith(tasks: tasks);
        return true;
      }
    } else {
      final result = await updateTaskUseCase.call(Pair(task, user));
      final updatedTask = result.fold((l) => null, (r) => r);
      if (updatedTask != null) {
        final tasks = state.tasks
            .map((e) => e.id == updatedTask.id ? updatedTask : e)
            .toList();
        state = state.copyWith(tasks: tasks);
        return true;
      }
    }

    return false;
  }

  Future<bool> deleteTask(String taskId) async {
    final user = User.current();
    final result = await deleteTaskUseCase.call(Pair(taskId, user));
    final deletedTaskId = result.fold((l) => null, (r) => r);
    if (deletedTaskId != null) {
      final tasks = state.tasks.where((e) => e.id != deletedTaskId).toList();
      state = state.copyWith(tasks: tasks);
      return true;
    }
    return false;
  }

  Future<List<Comment>> getComments(String taskId) async {
    final user = User.current();
    final result = await getCommentsByTaskIdUseCase.call(Pair(taskId, user));
    return result.fold((l) => [], (r) => r);
  }

  Future<String?> deleteComment(String commentId) async {
    final user = User.current();
    final result = await deleteCommentUseCase.call(Pair(commentId, user));
    final deletedCommentId = result.fold((l) => null, (r) => r);
    return deletedCommentId;
  }

  Future<Comment?> createComment(Comment comment) async {
    final user = User.current();
    final result = await createCommentUseCase.call(Pair(comment, user));
    final createdComment = result.fold((l) => null, (r) => r);
    return createdComment;
  }
}
