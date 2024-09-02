void main(List<String> args) {
  // final vs const

  // final
  const int x = 10;
  // x = 20; // error

  print(x);

  x = 99;
  print(x);

  // const
  const int y = 20;
  // y = 30; // error
}
