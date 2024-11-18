import 'package:floor/floor.dart';
import 'package:todo_list_base/model/project.dart';
import 'package:todo_list_base/model/project_todo_status_counts.dart';

// Todo : add the ProjectDao class
@dao
abstract class ProjectDao {
  @Query('SELECT * FROM projects')
  Stream<List<Project>> observeProjects();

  @Query('SELECT * FROM projects WHERE id = :pid')
  Future<Project?> findProjectById(int pid);

  @insert
  Future<void> addProject(Project project);

  @update
  Future<void> updateProject(Project project);

  @delete
  Future<void> deleteProject(Project project);

  @Query('SELECT * FROM ProjectTodoStatusCounts WHERE id = :pid')
  Stream<List<ProjectTodoStatusCounts?>> observeProjectTodoStatusCounts(
      int pid);
}
