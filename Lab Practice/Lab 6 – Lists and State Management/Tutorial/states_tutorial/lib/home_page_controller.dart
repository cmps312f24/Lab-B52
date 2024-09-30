import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _fistInputController = TextEditingController();
  var _secondInputController = TextEditingController();

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
              controller: _fistInputController,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              controller: _secondInputController,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    addButtonResult = double.parse(_fistInputController.text) +
                        double.parse(_secondInputController.text);

                    _fistInputController.clear();
                    _secondInputController.clear();
                  });
                },
                child: const Text('+')),
            const SizedBox(height: 20),
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
