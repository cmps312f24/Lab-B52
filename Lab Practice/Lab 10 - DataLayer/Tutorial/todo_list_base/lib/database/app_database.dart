//also this guy
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:todo_list_base/database/project_dao.dart';
import 'package:todo_list_base/database/todo_dao.dart';
import 'package:todo_list_base/model/project.dart';
import 'package:todo_list_base/model/project_todo_status_counts.dart';
import 'package:todo_list_base/model/todo.dart';

// do not remove this guys
import 'package:sqflite/sqflite.dart' as sqflite;
part 'app_database.g.dart';

// Todo AppDatabase class which extends FloorDatabase
@Database(
  version: 1,
  entities: [Project, Todo],
  views: [ProjectTodoStatusCounts],
)
abstract class AppDatabase extends FloorDatabase {
  ProjectDao get projectDao;
  TodoDao get todoDao;
}
