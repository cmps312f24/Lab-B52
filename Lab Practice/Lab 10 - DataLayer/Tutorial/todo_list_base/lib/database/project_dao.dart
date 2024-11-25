import 'package:floor/floor.dart';
import 'package:todo_list_base/model/project.dart';
import 'package:todo_list_base/model/project_todo_status_counts.dart';

// Todo : add the ProjectDao class

@dao
abstract class ProjectDao {
  @Query("SELECT * FROM projects")
  Stream<List<Project>> observeProjects();

  @delete
  Future<void> deleteProject(Project project);

  @insert
  Future<void> addProject(Project project);

  @update
  Future<void> updateProject(Project project);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> upsertProject(Project project);

  @Query("SELECT * FROM ProjectTodoStatusCounts WHERE id = :pid")
  Stream<ProjectTodoStatusCounts?> observeProjectTodoStatusCounts(int pid);
}
