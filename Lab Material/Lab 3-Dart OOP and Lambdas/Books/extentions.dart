extension on List<int> {
  void printElements() {
    for (int i = 0; i < this.length; i++) {
      print(this[i]);
    }
  }

  int sum() {
    return this.reduce((a, b) => a + b);
  }
}

extension on String {
  void printString() {
    print(this);
  }

  void log() {
    print("Log: $this");
  }
}

void main(List<String> args) {
  List<int> list = [1, 2, 3, 4, 5];
  List<String> stringList = ["Hello", "World"];

  list.printElements();
  print(list.sum());

  "Hello World".printString();

  "Error".log();
}
