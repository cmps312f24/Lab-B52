import 'package:go_router/go_router.dart';

import 'package:qbanking_app/screens/account_screen.dart';
import 'package:qbanking_app/screens/deposit_screen.dart';
import 'package:qbanking_app/screens/home_screen.dart';
import 'package:qbanking_app/screens/new_transfer_screen.dart';
import 'package:qbanking_app/screens/shell_screen.dart';
import 'package:qbanking_app/screens/transactions_screen.dart';
import 'package:qbanking_app/screens/transfer_screen.dart';

class AppRouter {
  static const home = (name: 'home', path: '/');
  static const account = (name: 'account', path: '/account');
  static const transfer = (name: 'transfer', path: '/transfer');
  static const transaction = (name: 'transaction', path: '/transaction');
  static const newTransfer =
      (name: 'newTransfer', path: '/transfer/newTransfer');
  static const deposit = (name: 'deposit', path: '/deposit:accountNo');
  static const withdraw = (name: 'withdraw', path: '/withdraw:accountNo');

  /*
      ShellRouter(
      routes : [],
      builder : (context , state , child) => ShellScreen(child : state.child)
      
      )
  */

  static final router = GoRouter(
    initialLocation: home.path,
    routes: [
      ShellRoute(
        builder: (context, state, child) => ShellScreen(child: child),
        routes: [
          GoRoute(
            name: home.name,
            path: home.path,
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: account.path,
                name: account.name,
                builder: (context, state) => const AccountScreen(),
              ),
              GoRoute(
                  path: transfer.path,
                  name: transfer.name,
                  builder: (context, state) => const TransferScreen(),
                  routes: [
                    GoRoute(
                      name: newTransfer.name,
                      path: newTransfer.path,
                      builder: (context, state) => const NewTransferScreen(),
                    )
                  ]),
              GoRoute(
                path: transaction.path,
                name: transaction.name,
                builder: (context, state) => const TransactionsScreen(),
              ),
              GoRoute(
                path: deposit.path,
                name: deposit.name,
                builder: (context, state) {
                  final accountNo = state.pathParameters['accountNo'];
                  return DepositScreen(accountNo: accountNo!);
                },
              ),
              GoRoute(
                path: withdraw.path,
                name: withdraw.name,
                builder: (context, state) {
                  final accountNo = state.pathParameters['accountNo'];
                  return DepositScreen(accountNo: accountNo!);
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

/*
1. to avoid mistakes I will create constants for all my string paths
const accounts = (name 'accounts' path 'a/b/c')
accounts.name
'/a'
'/a/b/c'

2. to configure our router
-create an instance of go_router

- /
- /accounts
- /accounts/deposit
- /accounts/withdraw
- /accounts/transfer
 - /accounts/transfer/confirm

const myRouter = GoRouter(
  initialLocation: '/',
  routes : [
      GoRoute(
        name : 'home.name'
        path : '/'
        builder : (context , state) => HomeScreen(),
        routes : [
          GoRoute(
            name : accounts.name
            path : accounts.path
            builder : (context , state) => AccountScreen(),
            routes : [
              GoRoute(
                name : 'deposit.name'
                path : 'deposit'
                builder : (context , state) => DepositScreen(),
              ),
              GoRoute(
                name : 'withdraw.name'
                path : 'withdraw'
                builder : (context , state) => WithdrawScreen(),
              ),
              GoRoute(
                name : 'transfer.name'
                path : 'transfer'
                builder : (context , state) => TransferScreen(),
                routes : [
                  GoRoute(
                    name : 'confirm.name'
                    path : 'confirm'
                    builder : (context , state) => ConfirmScreen(),
                  )
                ]
              )
        ]
      )
  ]
)


const myRouter = GoRouter(
  initialLocation: '/',
  routes : [
  GoRoute(
    name : home.name
    path : home.path
    builder : (context , state) => HomeScreen()

    )
    GoRoute(
    name : accounts.name
    path : accounts.path
    builder : (context , state) => AccountScreen()

    )
  ]
)

3. take the configuration and add it to your app

MaterialApp.router(routerConfig : myRouter)

4. 
context.go(accounts.path)
context.goName(accounts.name)

context.push(accounts.path)
context.pop()

context.pushName(accounts.name)



*/
