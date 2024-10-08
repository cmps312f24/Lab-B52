import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var firstInput = 0.0;
  var secondInput = 0.0;
  var addButtonResult = 0.0;
  @override
  Widget build(BuildContext context) {
    print('I am rebuilding');
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              onChanged: (value) {
                setState(() {
                  firstInput = double.parse(value);
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              onChanged: (value) {
                setState(() {
                  secondInput = double.parse(value);
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    addButtonResult = firstInput + secondInput;
                  });
                },
                child: const Text('+')),
            const SizedBox(height: 20),
            Text(
              'Auto Result : ${firstInput + secondInput}',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Button Add Result : $addButtonResult',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
