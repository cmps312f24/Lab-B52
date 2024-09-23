void main(List<String> args) {
  var person = createPerson('Dart', 10);
  print('name = ${person.$1}, age = ${person.$2}');

  var person2 = createPersonNamed('Dart', 10);
  print('name = ${person2.name}, age = ${person2.age}');

  var json = {
    'user': {'name': 90, 'age': 10, 'email': 'a@a.com'}
  };

  // check if the json is a Map
  // check if the json has a key 'user'
  //extract the user object and save it in a variable named user
  // again check if the user is a Map
  // if the user has a key 'name' and 'age' and 'email'
  // name is of type String , age is type int and email is of type String
  // extract the name, age and email from the user object and save them in variables named name, age and email respectively

  if (json
      case {
        'user': {'name': String name, 'age': int age, 'email': String email}
      }) {
    print('name = $name, age = $age, email = $email');
  } else {
    print('Invalid json');
  }
  // if(json is Map && json.containsKey('user')){
  //   var user = json['user'];
  //   if(user is Map && user.containsKey('name') && user.containsKey('age') && user.containsKey('email')){
  //     var name = user['name'];
  //     var age = user['age'];
  //     var email = user['email'];
  //     print('name = $name, age = $age, email = $email');
  //   }
  // }
}

(String name, int age) createPerson(String name, int age) {
  return (name, age);
}

({String name, int age}) createPersonNamed(String name, int age) {
  return (name: name, age: age);
}
