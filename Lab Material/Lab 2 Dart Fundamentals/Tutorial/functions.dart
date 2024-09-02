int add(int a, int b) {
  return a + b;
}

// positional arguments with default values[optional value]
int add2(int a, [int b = 55]) {
  return a + b;
}

// named parameters
int add3({required int a, required int b}) {
  return a + b;
}

var add4 = () {
  return 10 + 20;
};

void main(List<String> args) {
  int x = 10;
  int y = 20;
  print(add(x, y));

  print(add2(10));

  print(add3(b: 40, a: 10));

  print(add4());

  var myCoolAdd = (a, b) => a + b;

  print(myCoolAdd(1000, 20));
}

var scienceFail = (int grade) => grade > 60 ? 1 : 0;
var artFail = (int grade) => grade > 70 ? 1 : 0;

int fail(int grade, Function failFunction) {
  return failFunction(grade);
}
