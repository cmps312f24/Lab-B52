import 'package:floor/floor.dart';

// Todo : add the @Databaseview annotation
class ProjectTodoStatusCounts {
  @primaryKey
  final int id;
  final int pendingCount;
  final int completedCount;

  ProjectTodoStatusCounts({
    required this.id,
    required this.pendingCount,
    required this.completedCount,
  });
}
