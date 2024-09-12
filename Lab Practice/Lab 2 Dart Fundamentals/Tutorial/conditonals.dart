void main(List<String> args) {
  int age = 25;
  if (age > 18) {
    print('You are an adult');
  } else if (age < 18) {
    print('You are a minor');
  } else {
    print('You are a teenager');
  }

  // let use ternary operator
  String result = age > 18 ? 'You are an adult' : 'You are a minor';

  String letterGrade = switch (90) {
    > 90 && < 100 => ('A'),
    80 => ('B'),
    70 => ('C'),
    60 => ('D'),
    _ => ('F')
  };
  print('You got a $letterGrade');
}

String getLetterGrade(int grade) {
  // switch case
  switch (grade) {
    case 90:
      return ('A');
    case 80:
      return ('B');
    case 70:
      return ('C');
    case 60:
      return ('D');
    default:
      return ('F');
  }
}
