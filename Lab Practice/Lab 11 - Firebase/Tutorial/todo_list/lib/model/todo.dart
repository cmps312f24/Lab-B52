class Todo {
  String id;

  final String title;
  final String status;
  final String priority;
  final String date;
  final String time;

  final String pid;

  Todo(
    this.id,
    this.title,
    this.status,
    this.priority,
    this.date,
    this.time,
    this.pid,
  );

  factory Todo.fromMap(Map<String, dynamic> json) {
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

  Map<String, dynamic> toMap() {
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
