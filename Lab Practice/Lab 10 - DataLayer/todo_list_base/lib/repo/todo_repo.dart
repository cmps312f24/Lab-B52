import 'package:todo_list_base/database/project_dao.dart';
import 'package:todo_list_base/database/todo_dao.dart';
import 'package:todo_list_base/model/project.dart';
import 'package:todo_list_base/model/project_todo_status_counts.dart';
import 'package:todo_list_base/model/todo.dart';

class TodoListRepo {
  final ProjectDao projectDao;
  final TodoDao todoDao;

  TodoListRepo({required this.projectDao, required this.todoDao});

  // Create the Repo methods
}
