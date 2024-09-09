import 'dart:io';

void main(List<String> args) {}

extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }

  double parseDouble() {
    return double.parse(this);
  }
}

void displayEven() {
  for (var i = 1; i <= 100; i++) {
    if (i % 2 == 0) stdout.write(i.toString() + " ");
    if (i % 10 == 0) print("");
  }
}

String getLetterGrade(int grade) {
  return switch (grade) {
    < 60 => 'F',
    < 65 => 'D+',
    < 70 => 'D',
    < 75 => 'C',
    < 80 => 'C+',
    < 85 => 'B',
    < 90 => 'B+',
    _ => 'A',
  };
}
