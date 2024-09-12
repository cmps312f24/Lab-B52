void main(List<String> args) {
  // how to declare and use variables
  int? age;
  String name = 'John Doe';
  var height;
  bool isMarried = false;

  height = "Hello"; // error
  print(height);

  height = 5.5;

  // // two more
  // var weight = 70;
  dynamic salary = 50000;

  salary = "Fifty thousand";

  print(salary);

  // List
  List<String> names = ['John', 'Doe', 'Jane'];
  List<dynamic> values = [1, 'two', 3.0];

  // Set
  Set<String> uniqueNames = {'John', 'Doe', 'Jane'};

  // Map
  // Map<keyType, ValueType>
  Map<String, dynamic> person = {
    'name': 'John Doe',
    'age': 30,
    'isMarried': false
  };

  print(person['name']);

  // const and final

  final int x;
  x = 10;
  print(x);
}
