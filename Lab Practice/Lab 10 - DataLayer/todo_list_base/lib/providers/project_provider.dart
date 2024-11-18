import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo_list_base/model/project.dart';
import 'package:todo_list_base/model/project_todo_status_counts.dart';
import 'package:todo_list_base/providers/repo_provider.dart';
import 'package:todo_list_base/repo/todo_repo.dart';

class ProjectNotifier extends AsyncNotifier<List<Project>> {
  late final TodoListRepo _todoListRepo;

  @override
  Future<List<Project>> build() async {
    // Todo add the _todoListRepo initialization
    // Todo add the _todoListRepo.projectDao.observeProjects().listen((projects) { state = AsyncData(projects); });

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

  Stream<ProjectTodoStatusCounts?> getProjectTodosStatusCounts(int projectId) =>
      _todoListRepo.getProjectTodosStatusCounts(projectId);
}

final projectNotifierProvider =
    AsyncNotifierProvider<ProjectNotifier, List<Project>>(
        () => ProjectNotifier());
