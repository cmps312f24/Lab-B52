import 'package:floor/floor.dart';

// Todo : add the @Databaseview annotation
@DatabaseView('''
  SELECT 
    p.id AS id,
    IFNULL(SUM(CASE WHEN t.status = 'pending' THEN 1 ELSE 0 END), 0) AS pendingCount,
    IFNULL(SUM(CASE WHEN t.status = 'completed' THEN 1 ELSE 0 END), 0) AS completedCount
  FROM projects p
  LEFT JOIN todos t ON p.id = t.pid
  GROUP BY p.id
''')
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
