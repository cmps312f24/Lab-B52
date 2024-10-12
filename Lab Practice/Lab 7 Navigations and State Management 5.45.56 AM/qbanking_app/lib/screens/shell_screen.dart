import 'package:flutter/material.dart';

class ShellScreen extends StatelessWidget {
  final Widget? child;
  const ShellScreen({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QCB Bank',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            letterSpacing: 1.5,
          ),
        ),
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        // set the current index
        currentIndex: 0,

        // make it active when selected
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Accounts',
          )
        ],
        onTap: (index) {
          if (index == 0) {
            //todo  add navigation
          } else {
            //todo add navigation
          }
        },
      ),
    );
  }
}
