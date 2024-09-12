void main(List<String> args) {
  List<int> numbers = [1, 2, 3, 4, 5];
  // List<String> names = ['John', 'Doe', 'Janed'];

  // // for loop
  // for (int i = 0; i < numbers.length; i++) {
  //   print(numbers[i]);
  // }

  // // display things [for each]
  // numbers.forEach((x) => print("The number is $x"));
  // numbers.forEach((x) => print(x * x));

  // transformation [changing a => b]

  // var mappedValues = numbers.map((x) => x * x).toList();
  // print(numbers);
  // print(mappedValues);

  // var nameLength = names.map((name) => name.length).toList();
  // print(names);
  // print(nameLength);
  print(numbers);
  int sum = numbers.reduce(add);
  int sum2 = numbers.reduce((a, b) => a + b);
  print("Sum is $sum");
  print("Sum 2 is $sum2");
}

int add(int a, int b) {
  print("a is $a and b is $b");
  return a + b;
}
