import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var textFieldInput = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            onChanged: (value) {
              textFieldInput = value;
              setState(() {              
              });
              print('textFieldInput : $textFieldInput');
            },
          ),
          Text('Display : $textFieldInput'),
        ],
      ),
    );
  }
}
