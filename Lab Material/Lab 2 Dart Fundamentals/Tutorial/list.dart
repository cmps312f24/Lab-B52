void main(List<String> args) {
  // working with collections
  List<int> numbers = [1, 2, 3, 4, 5];

  // display all the elements
  for (int i = 0; i < numbers.length; i++) {
    print(numbers[i]);
  }

  // numbers.forEach((int number) => print("hello mr . $number"));
  dynamic mapped = numbers.map(map3);
  print(mapped);

  // summing
  print(numbers);
  int sum = numbers.reduce((acc, cur) => acc + cur);
  print(sum);

  // fold

  print("Folding");
  print(numbers);
  int folded = numbers.fold(1, (acc, cur) => acc * cur);
}

int add(int a, int b) {
  print("a: $a, b: $b");
  return a + b;
}

int map1(int number) {
  return number * 2;
}

int map2(int number) {
  return number * 3;
}

int map3(int number) {
  return number * 3;
}
