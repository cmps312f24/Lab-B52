class Project {
  String id;
  final String name;

  Project(this.id, this.name);

  factory Project.fromMap(Map<String, dynamic> json) {
    return Project(json['id'], json['name']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'Project{id: $id, name: $name}';
  }
}
