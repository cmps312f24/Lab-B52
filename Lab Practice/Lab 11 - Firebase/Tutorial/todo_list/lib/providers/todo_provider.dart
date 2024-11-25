import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/model/todo.dart';
import 'package:todo_list/providers/repo_provider.dart';
import 'package:todo_list/repo/todo_repo.dart';

class TodoNotifier extends AsyncNotifier<List<Todo>> {
  TodoListRepo? _todoListRepo;

  @override
  Future<List<Todo>> build() async {
    _todoListRepo = await ref.watch(todoListRepoProvider.future);
    final projectId = ref.watch(selectedProjectIdProvider);

    _todoListRepo?.observeTodos(projectId!).listen((todos) {
      state = AsyncData(todos);
    });

    return [];
  }

  void addTodo(Todo todo) => _todoListRepo?.addTodo(todo);
  void updateTodo(Todo todo) => _todoListRepo?.updateTodo(todo);
  void deleteTodo(Todo todo) => _todoListRepo?.deleteTodo(todo);
}

final todoNotifierProvider =
    AsyncNotifierProvider<TodoNotifier, List<Todo>>(() => TodoNotifier());
