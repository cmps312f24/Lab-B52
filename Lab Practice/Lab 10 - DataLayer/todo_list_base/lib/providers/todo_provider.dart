import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_base/model/todo.dart';
import 'package:todo_list_base/providers/repo_provider.dart';
import 'package:todo_list_base/repo/todo_repo.dart';

class TodoNotifier extends AsyncNotifier<List<Todo>> {
  TodoListRepo? _todoListRepo;
  // late final int _projectId;

  @override
  Future<List<Todo>> build() async {
    _todoListRepo = await ref.watch(todoListRepoProvider.future);
    final projectId = ref.watch(selectedProjectIdProvider);

    _todoListRepo?.observeTodos(projectId!).listen((todos) {
      state = AsyncData(todos);
    });

    return [];
  }

  void addTodo(Todo todo) async {
    await _todoListRepo?.addTodo(todo);
  }

  void updateTodo(Todo todo) async {
    await _todoListRepo?.updateTodo(todo);
  }

  void deleteTodo(Todo todo) async {
    try {
      await _todoListRepo?.deleteTodo(todo);
    } catch (e) {
      print(e);
    }
  }
}

final todoNotifierProvider =
    AsyncNotifierProvider<TodoNotifier, List<Todo>>(() => TodoNotifier());
