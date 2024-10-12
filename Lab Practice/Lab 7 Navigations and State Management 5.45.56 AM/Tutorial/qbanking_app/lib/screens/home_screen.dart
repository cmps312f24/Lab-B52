import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qbanking_app/routes/app_router.dart';
import 'package:qbanking_app/screens/shell_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/banner.jpg'),
          Expanded(
            child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                children: [
                  const Card(
                    elevation: 5,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.money),
                          Text(
                            'Deposit',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.goNamed(AppRouter.deposit.name,
                          pathParameters: {'accountNo': '1234567890'});
                    },
                    child: const Card(
                      elevation: 5,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.money_off),
                            Text(
                              'Withdraw',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.goNamed(AppRouter.transfer.name);
                    },
                    child: const Card(
                      elevation: 5,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.swap_horiz),
                            Text(
                              'Transfer',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.goNamed(AppRouter.transactions.name);
                    },
                    child: const Card(
                      elevation: 5,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.history),
                            Text(
                              'Transactions ',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
