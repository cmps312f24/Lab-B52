import 'package:go_router/go_router.dart';
import 'package:todo_list/screens/project_screen.dart';
import 'package:todo_list/screens/todo_screen.dart';

class AppRouter {
  static const projectScreen = (name: 'projects', path: '/projects');
  static const todoScreen = (name: 'todos', path: '/:pid/todos');

  static final appRouter = GoRouter(routes: [
    GoRoute(
      path: projectScreen.path,
      builder: (context, state) => const ProjectScreen(),
      routes: [
        GoRoute(
          path: todoScreen.path,
          builder: (context, state) {
            final pid = state.pathParameters['pid']!;
            return TodoScreen(pid: pid);
          },
        ),
      ],
    ),
  ], initialLocation: projectScreen.path);
}
