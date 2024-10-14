import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qbanking_app/providers/title_provider.dart';
import 'package:qbanking_app/routes/app_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final List<Map<String, dynamic>> _menuItems = [
    {
      'label': 'Withdraw',
      'icon': Icons.money,
      'routeName': AppRouter.withdraw.name,
      'params': {'accountNo': '123456'},
    },
    {
      'label': 'Deposit',
      'icon': Icons.account_balance_wallet,
      'routeName': AppRouter.deposit.name,
      'params': {'accountNo': '123456'},
    },
    {
      'label': 'Transfers',
      'icon': Icons.transfer_within_a_station,
      'routeName': AppRouter.transfer.name,
    },
    {
      'label': 'Transactions',
      'icon': Icons.play_lesson_outlined,
      'routeName': AppRouter.transaction.name,
    },
  ];
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
                for (var item in _menuItems)
                  GestureDetector(
                    onTap: () {
                      //todo navigate to the route
                      // context.go(item['route']);
                      // update the title
                      ref
                          .read(appTitleNotifierProvider.notifier)
                          .setTitle(item['label']);
                      if (item['label'] == 'Withdraw' ||
                          item['label'] == 'Deposit') {
                        context.pushNamed(item['routeName'],
                            pathParameters: item['params']);
                      } else {
                        context.pushNamed(item['routeName']);
                      }
                    },
                    child: Card(
                      elevation: 5,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item['icon']),
                            Text(
                              item['label'],
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
