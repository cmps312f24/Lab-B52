import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
          actions: const [
            Icon(Icons.search, color: Colors.white),
            Icon(Icons.notifications, color: Colors.white),
            SizedBox(width: 20),
          ],
        ),
        body: Column(
          children: [
            const Welcome(),
            const SizedBox(height: 20),
            Container(
              width: 300,
              height: 100,
              color: Colors.red,
              child: const Center(
                child: Text(
                  'This is also another text',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7_NqNG8mhl2cVrfBudJ78tluJz2T0oaV11USQCJFt9vKpO4lM4lY7VSjQ6AhhzQKOhXM&usqp=CAU'),
          ],
        ),
      ),
    );
  }
}

class Welcome extends StatelessWidget {
  const Welcome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
      child: Center(
        child: Container(
          height: 200,
          decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(10)),
          child: const Center(
            child: Text(
              'Hello, World I am here too!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'Times New Roman',
                  letterSpacing: 5,
                  wordSpacing: 5,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
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
