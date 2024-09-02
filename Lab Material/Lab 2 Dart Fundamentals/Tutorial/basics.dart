// Learn the basics of dart programming language

// Data types

void main(List<String> args) {
  int age = 20;
  String name = "John Doe";
  double height = 5.8;
  bool isStudent = true;
  var gender = "Male";

  dynamic weight = 70;
  weight = "70kg";
  print(weight);

  int? x;

  x = 10;

  print(x);

  // List
  List<int> numbers = [1, 2, 3, 4, 5];
  List<String> names = ["John", "Doe", "Jane"];
  List<dynamic> mixed = [1, "Doe", "Jane"];

  print(names[0]);
  print(numbers[2]);

  // Set
  Set<int> setNumbers = {1, 2, 3, 4, 5};

  // Map
  Map<String, dynamic> person = {
    "name": "John Doe",
    "age": 20,
    "isStudent": true
  };

  // conditional statements

  if (age > 18) {
    print("You are an adult");
  } else if (age == 18) {
    print("You are a teenager");
  } else {
    print("You are a minor");
  }

  // Ternary operator
  String result = age > 18 ? "Adult" : "Minor";
  print(result);

  for (int i = 0; i < numbers.length; i++) {
    print(numbers[i]);
  }

  int t = 10;
  int b = 20;
}

// functions
int add(int a, int b) {
  return a + b;
}

int add2(int a, int b) => a + b;

// assign functions to variables
var sum = (int a, int b) => a + b;

// a function that returns pass or fail
String passOrFail(int marks) => marks >= 60 ? "Pass" : "Fail";
String passOrFail(int marks) {
  if (marks >= 60) {
    return "Pass";
  } else {
    return "Fail";
  }
}

// Arrow function
int multiply(int a, int b) => a * b;

//
// Functions
String getLevel(int level) {
  greet3(lastName: 55, firstName: "Ali");
  return switch (level) {
    1 => "Beginner",
    2 => "Intermediate",
    _ => "Invalid level",
  };
}

// functions with positional parameters
void greet2(String name, [int age = 30]) {
  print("Hello $name your age is  $age ");
}

// named parameters
void greet3({required String firstName, required String lastName}) {
  print("Hello $firstName your age is  $lastName");
}
