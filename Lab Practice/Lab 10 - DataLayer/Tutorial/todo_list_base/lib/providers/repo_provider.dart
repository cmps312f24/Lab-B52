import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_base/repo/todo_repo.dart';
import '../database/app_database.dart';

//Todo todoListRepoProvider which is a future provider that returns a TodoListRepo instance
final todoListRepoProvider = FutureProvider<TodoListRepo>((ref) async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  return TodoListRepo(
      projectDao: database.projectDao, todoDao: database.todoDao);
});

// selectedProjectIdProvider which is a state provider that returns an integer value
final selectedProjectIdProvider = StateProvider<int?>((ref) => null);
