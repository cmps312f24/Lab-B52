import 'package:go_router/go_router.dart';
import 'package:qbanking_app/model/account.dart';
import 'package:qbanking_app/screens/account_screen.dart';
import 'package:qbanking_app/screens/home_screen.dart';

class AppRouter {
  //good coding practice to avoid mistakes
  static const home = (name: 'home', path: '/');
  static const account = (name: 'account', path: 'account');
  static const deposit = (name: 'deposit', path: 'deposit');
  static const transfer = (name: 'transfer', path: 'transfer');
  static const transactions = (name: 'transactions', path: 'transactions');

  // to create the router

  static final router = GoRouter(
    initialLocation: home.path,
    routes: [
      GoRoute(
          name: home.name,
          path: home.path,
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              name: account.name,
              path: account.path,
              builder: (context, state) => const AccountScreen(),
            ),
          ]),
    ],
  );
}
