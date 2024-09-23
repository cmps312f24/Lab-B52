import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hello, World!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        leading: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
      ),
      body: const Text(
        'Hello, World I am here too!',
        style: TextStyle(
            color: Colors.red,
            fontSize: 25,
            fontFamily: 'Times New Roman',
            letterSpacing: 5,
            wordSpacing: 5,
            fontWeight: FontWeight.bold),
      ),
    ),
  ));
}



// class A {
//   final B b;
//   A({required this.b});
// }

// class B {
//   final C c;
//   B({required this.c});
// }

// class C {
//   final D d;
//   C({required this.d});
// }

// class D {
//   final int e;
//   D({required this.e});
// }

// var a = A(
//     b: B(
//       c: C(
//         d: D(
//           e: 2
//           )
//           )
//           )
//           );
