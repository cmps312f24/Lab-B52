import 'package:floor/floor.dart';
import 'package:todo_list_base/model/project.dart';

// todo : add the @Entity annotation with ForeignKey
class Todo {
  // id, title, status, priority, data , time, pid
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String title;
  final String status;
  final String priority;
  final String date;
  final String time;

  final int pid;

  Todo(
    this.id,
    this.title,
    this.status,
    this.priority,
    this.date,
    this.time,
    this.pid,
  );

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      json['id'],
      json['title'],
      json['status'],
      json['priority'],
      json['date'],
      json['time'],
      json['pid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': status,
      'priority': priority,
      'date': date,
      'time': time,
      'pid': pid,
    };
  }

  @override
  String toString() {
    return 'Todo{id: $id, title: $title, status: $status, priority: $priority, date: $date, time: $time, pid: $pid}';
  }
}
