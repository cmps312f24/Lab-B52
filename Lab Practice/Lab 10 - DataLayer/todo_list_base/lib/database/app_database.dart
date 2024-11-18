import 'dart:async';

import 'package:floor/floor.dart';
import 'package:todo_list_base/database/project_dao.dart';
import 'package:todo_list_base/database/todo_dao.dart';
import 'package:todo_list_base/model/project.dart';
import 'package:todo_list_base/model/project_todo_status_counts.dart';
import 'package:todo_list_base/model/todo.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

// Todo AppDatabase class which extends FloorDatabase
