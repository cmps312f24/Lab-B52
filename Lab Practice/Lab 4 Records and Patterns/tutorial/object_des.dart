void main(List<String> args) {
  var json = {
    'name': 'Dart',
    'age': 10,
    'email': 'a@a.com',
  };

  // var name = json['name'];
  // var age = json['age'];
  // var email = json['email'];

  var {'name': name, 'age': age, 'email': email} = json;
  print('name = $name, age = $age, email = $email');

  Person p = Person(name: 'Dart', age: 10, email: 'a@a,com');
  var Person(name: String n) = p;
  var n2 = p.name;

  print('name = $n');

  switch (p) {
    case Person(name: 'Dart', age: 10, email: 'a@a.com'):
      print('Dart');
      break;
  }
  
}

class Person {
  String name;
  int age;
  String email;

  Person({required this.name, required this.age, required this.email});
}

