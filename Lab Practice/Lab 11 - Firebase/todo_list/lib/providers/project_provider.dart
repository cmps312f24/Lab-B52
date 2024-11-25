import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/model/project.dart';
import 'package:todo_list/model/project_todo_status_counts.dart';
import 'package:todo_list/providers/repo_provider.dart';
import 'package:todo_list/repo/todo_repo.dart';

class ProjectNotifier extends AsyncNotifier<List<Project>> {
  late final TodoListRepo _todoListRepo;

  @override
  Future<List<Project>> build() async {
    _todoListRepo = await ref.watch(todoListRepoProvider.future);

    // Listen to the stream and emit the data
    _todoListRepo.observeProjects().listen((projects) {
      state = AsyncValue.data(projects);
    }).onError((error) {
      print(error);
    });

    return []; // Initial empty state
  }

  void addProject(Project project) async {
    await _todoListRepo.addProject(project);
  }

  void updateProject(Project project) async {
    await _todoListRepo.updateProject(project);
  }

  void deleteProject(Project project) async {
    try {
      await _todoListRepo.deleteProject(project);
    } catch (e) {
      print(e);
    }
  }

  Stream<ProjectTodoStatusCounts?> getProjectTodosStatusCounts(
          String projectId) =>
      _todoListRepo.getProjectTodosStatusCounts(projectId);
}

final projectNotifierProvider =
    AsyncNotifierProvider<ProjectNotifier, List<Project>>(
        () => ProjectNotifier());
