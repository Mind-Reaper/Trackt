import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trackt/core/extensions/duration_extension.dart';
import 'package:trackt/core/state_controllers.dart';
import 'package:trackt/features/time_tracker/external/presentation/pages/tracking_history_page.dart';
import 'package:trackt/features/todo/external/models/section/section.dart';
import 'package:trackt/features/todo/external/presentation/pages/section_column.dart';
import 'package:trackt/shared/widgets/loading_overlay.dart';
import 'package:collection/collection.dart';

class ProjectPage extends ConsumerStatefulWidget {
  const ProjectPage({super.key});

  @override
  ConsumerState<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends ConsumerState<ProjectPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final projectNotifier = ref.read(projectController.notifier);
    final projectState = ref.watch(projectController);
    final trackerNotifier = ref.read(trackerController.notifier);
    final trackerState = ref.watch(trackerController);

    final project = projectState.project;
    final sections = projectState.sections;
    final sectionsIncomplete = sections.length < SectionName.values.length;

    final lastTracker = trackerState.currentTracker.isEmpty
        ? trackerState.trackers.lastOrNull
        : trackerState.currentTracker;
    final lastTrackedTask = lastTracker == null
        ? null
        : projectState.tasks
            .firstWhereOrNull((e) => e.id == lastTracker.taskId);

    final lastTrackedTotalElapsed = lastTracker == null
        ? const Duration()
        : trackerState.trackers
            .where((e) => lastTracker.taskId == e.taskId)
            .fold<Duration>(
                const Duration(),
                (previousValue, element) =>
                    previousValue + (element.elapsed ?? const Duration()));

    bool isRunningTracker =
        trackerState.currentTracker.taskId == (lastTrackedTask?.id ?? '') &&
            trackerState.currentTracker.isRunning;
    return LoadingOverlay(
      loading: projectState.loading,
      message: project == null
          ? 'Fetching Project'
          : sectionsIncomplete
              ? 'Fetching Sections'
              : null,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(project?.name ?? 'Trackt'),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (projectState.project == null) ...[
                  if (!projectState.loading)
                    const Text('Error Fetching Project'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        projectNotifier.init();
                      },
                      child: const Text('Retry'))
                ] else if (sectionsIncomplete) ...[
                  if (!projectState.loading)
                    const Text('Error Fetching Sections'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        projectNotifier.getProjectSections();
                      },
                      child: const Text('Retry'))
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Currently Tracking:',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_)=> const TrackingHistoryPage()));
                            }, child: const Text('View History'))
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lastTrackedTask?.content ?? 'No Task Tracked',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                lastTrackedTotalElapsed.toFormattedString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        if (lastTrackedTask != null)
                          IconButton(
                            icon: Icon(isRunningTracker
                                ? Icons.stop
                                : Icons.play_arrow),
                            iconSize: 30,
                            onPressed: () {
                              if (isRunningTracker) {
                                trackerNotifier
                                    .stopTracking(lastTrackedTask.id);
                              } else {
                                trackerNotifier
                                    .startTracking(lastTrackedTask.id);
                              }
                            },
                          ),
                      ],
                    ),
                  ),
                  Center(
                    child: Text(
                      trackerState.elapsed.toFormattedString(),
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: trackerState.currentTracker.isRunning
                              ? null
                              : Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Boards',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 24),
                      separatorBuilder: (_, __) => const SizedBox(
                        width: 30,
                      ),
                      itemCount: sections.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final section = sections[index];
                        return SectionColumn(section: section);
                      },
                    ),
                  )
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
