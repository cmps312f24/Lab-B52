void main(List<String> args) {
  // var a = 1;
  // var b = 2;

  var (a, b) = (1, 2);
  print('a = $a, b = $b');

  // swapping

  // var temp = a;
  // a = b;
  // b = temp;
  // records
  //pattern matching
  (a, b) = (b, a);
  print('a = $a, b = $b');

  // list destructuring
  var list = [11, 21, 111, 13, 1, -1, 88];
  list.sort();
  print(list);
  var [min, ..._, max] = list;
  print('min = $min, max = $max');

  var p = (name: 'Name of the person', age: 90, gender: 'Male');
  p.name;
  p.age;
  p.gender;
}

class Person {
  String name;
  int age;
  String email;

  Person({required this.name, required this.age, required this.email});
}
