import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/model/project.dart';
import 'package:todo_list/model/project_todo_status_counts.dart';
import 'package:todo_list/model/todo.dart';

class TodoListRepo {
  // final ProjectDao db;
  final CollectionReference projectRef;
  final CollectionReference todoRef;

  TodoListRepo({required this.projectRef, required this.todoRef});

  // projects
  Stream<List<Project>> observeProjects() =>
      projectRef.snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => Project.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
      });

  Future<Project?> getProjectById(String id) =>
      projectRef.doc(id).get().then((snapshot) {
        if (snapshot.exists) {
          return Project.fromMap(snapshot.data() as Map<String, dynamic>);
        } else {
          return null;
        }
      });
  Future<void> addProject(Project project) async {
    var docId = projectRef.doc().id;
    project.id = docId;
    await projectRef.doc(docId).set(project.toMap());
  }


  Future<void> updateProject(Project project);

  Future<void> deleteProject(Project project);

  // todos

  Stream<List<Todo>> observeTodos(String projectId);

  Future<Todo> getTodoById(String id) async {
    final snapshot = await todoRef.doc(id).get();
    return Todo.fromMap(snapshot.data() as Map<String, dynamic>);
  }

  Future<void> addTodo(Todo todo);

  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(Todo todo);
  Stream<ProjectTodoStatusCounts?> getProjectTodosStatusCounts(
          String projectId) =>
      todoRef.where('pid', isEqualTo: projectId).snapshots().map((snapshot) {
        final todos = snapshot.docs
            .map((doc) => Todo.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
        // print(todos);
        var counts = ProjectTodoStatusCounts(
          id: projectId,
          //ignore the case of status
          completedCount: todos
              .where((todo) => todo.status.toLowerCase() == 'completed')
              .length,
          pendingCount: todos
              .where((todo) => todo.status.toLowerCase() == 'pending')
              .length,
        );

        return counts;
      });
}
