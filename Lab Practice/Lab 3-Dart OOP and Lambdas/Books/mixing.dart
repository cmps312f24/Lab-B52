// mixin CanWalk {
//   void canWalk() {
//     print("I can walk");
//   }
// }
// mixin CanTalk {
//   void canTalk() {
//     print("I can walk");
//   }
//   void canJump() {
//     print("I can jump");
//   }
// }

// class Human with CanWalk, CanTalk {}

// class Cat {
//   void purr() {
//     print("Purr");
//   }
// }

// abstract class DomesticCat extends Cat with CanWalk implements Human {
//   @override
// //lot more cod
// }

class Lion extends Cat with CanWalk, CanTalk {
  // lot more code
  String name;
  int age;

  Lion(this.name, this.age);

  factory Lion.fromMap(Map<String, dynamic> lion) {
    return Lion(lion["name"], lion["age"]);
  }
  @override
  String toString() {
    return "Name: $name, Age: $age";
  }
}

void main(List<String> args) {
  Map<String, dynamic> lion1 = {
    "name": "Simba",
    "age": 2,
  };
  Map<String, dynamic> lion2 = {
    "name": "Simba",
    "age": 2,
  };
  List<Map<String, dynamic>> listOfLionMap = [lion1, lion2];

  // Lion simba = Lion.fromMap(lion);
  // simba.canWalk();

  List numbers = [13, 24, 3, 4, 5];
  numbers.sort();
}
