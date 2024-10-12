import 'package:flutter/material.dart';

class DepositScreen extends StatelessWidget {
  final String accountNo;
  const DepositScreen({super.key, required this.accountNo});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'This is the Deposit Screen',
          style: TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
        ),
        Text(
          'Account No: $accountNo',
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
