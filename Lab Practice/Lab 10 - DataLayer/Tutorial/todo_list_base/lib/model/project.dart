import 'package:floor/floor.dart';

// Todo : add the @entity annotation
class Project {
// Todo add the @PrimaryKey annotation with autoGenerate: true
  final int?
      id; //important to keep this guy nullable, so we can generate the id

  final String name;

  Project(this.id, this.name);

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(json['id'], json['name']);
  }

  Map<String, dynamic> toJson() {
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
