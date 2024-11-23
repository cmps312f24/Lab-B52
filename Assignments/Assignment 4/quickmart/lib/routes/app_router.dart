import 'package:go_router/go_router.dart';
import 'package:quickmart/screens/cart_screen.dart';
import 'package:quickmart/screens/favorites_screen.dart';
import 'package:quickmart/screens/product_details_screen.dart';
import 'package:quickmart/screens/product_screen.dart';
import 'package:quickmart/screens/shell_screen.dart';

class AppRouter {
  static const home = (name: 'QuickMart', path: '/');
  static const productDetails = (name: 'ProductDetails', path: '/product/:id');
  static const cart = (name: 'Cart', path: '/cart');
  static const favorites = (name: 'Favorites', path: '/favorites');

  static final router = GoRouter(
    initialLocation: home.path,
    routes: [
      ShellRoute(
        builder: (context, state, child) => ShellScreen(child: child),
        routes: [
          GoRoute(
            name: home.name,
            path: home.path,
            builder: (context, state) {
              return const ProductScreen();
            },
            routes: [
              GoRoute(
                name: favorites.name,
                path: favorites.path,
                builder: (context, state) {
                  return FavoritesScreen();
                },
              )
            ],
          ),
        ],
      ),
      GoRoute(
        name: productDetails.name,
        path: productDetails.path,
        builder: (context, state) {
          final productId =
              state.pathParameters['id']!; // Accessing the product ID
          return ProductDetailsScreen(
              productId: productId); // Pass the product ID
        },
      ),
      GoRoute(
        name: cart.name,
        path: cart.path,
        builder: (context, state) {
          // get query parameters
          final from = state.uri.queryParameters['from']!;
          return CartScreen(from: from);
        },
      )
    ],
  );
}
