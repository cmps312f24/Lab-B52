class Car {
  late String name;
  late String color;
  late String year;

  // Car(this.name, this.color);

  // // add another constructor named Car.named
  // // Car.named(String name, String color) : this(name , color);
  // // different types of constructors in dart programming language

  // Car.named({required this.name, required this.color, required this.year});

  // generate a toString method
  @override
  String toString() {
    return "Car(name: $name, color: $color, year: $year)";
  }
}

void main(List<String> args) {
  Car car = Car();
  car.name = "Toyota";
  car.color = "Red";
  car.year = "2021";

  // short way of initializing the object
  Car car2 = Car()
    ..name = "Toyota"
    ..color = "Red"
    ..year = "2021";

  print(car);
}
