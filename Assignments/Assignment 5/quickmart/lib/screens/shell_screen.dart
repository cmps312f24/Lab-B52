import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:quickmart/main.dart';
import 'package:quickmart/modal/search_modal.dart';
import 'package:quickmart/providers/product_provider.dart';
import 'package:quickmart/providers/search_provider.dart';
import 'package:quickmart/providers/title_provider.dart';
import 'package:quickmart/routes/app_router.dart';

class ShellScreen extends ConsumerStatefulWidget {
  final Widget? child;
  const ShellScreen({super.key, this.child});

  @override
  ConsumerState<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends ConsumerState<ShellScreen> {
  var title = "QuickMart";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    title = ref.watch(appTitleNotifierProvider);
    var currentRoute =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();

    currentRoute = currentRoute.split('?')[0];
    if (currentRoute.toString() == AppRouter.home.path.toString() &&
        title != AppRouter.home.name) {
      title = AppRouter.home.name;
    } else if (currentRoute.toString() == AppRouter.cart.path.toString() &&
        title != AppRouter.cart.name) {
      title = AppRouter.cart.name;
    } else if (currentRoute.toString() == AppRouter.favorites.path.toString() &&
        title != AppRouter.favorites.name) {
      title = AppRouter.favorites.name;
    }

    fToast = FToast();
    fToast.init(context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        title: title != 'QuickMart'
            ? Text(
                'Favorites',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1.5,
                  color: Colors.black,
                ),
              )
            : Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  letterSpacing: 1.5,
                  color: Colors.black,
                ),
              ),
        actions: [
          if (title == AppRouter.home.name)
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        height: 24,
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            border: InputBorder.none, // Remove border
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                          style: const TextStyle(color: Colors.grey),
                          onChanged: (value) => {
                            ref
                                .read(productProviderNotifier.notifier)
                                .filterProducts(ref
                                    .read(searchProviderNotifier.notifier)
                                    .setSearchText(value)),
                          },
                          onSubmitted: (query) {
                            ref
                                .read(productProviderNotifier.notifier)
                                .filterProducts(ref
                                    .read(searchProviderNotifier.notifier)
                                    .setSearchText(query));
                          },
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.tune),
                      color: Colors.grey,
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return FilterModal();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
        ],
        leading: title == AppRouter.home.name
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () {
                  context.goNamed(AppRouter.home.name);
                },
              ),
      ),
      body: Padding(padding: EdgeInsets.all(14.0), child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: title == AppRouter.home.name
            ? 0
            : title == AppRouter.cart.name
                ? 1
                : 2,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favorites',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            context.goNamed(AppRouter.home.name);
            showToast(message: 'Welcome to QuickMart');
          } else if (index == 1) {
            context.pushNamed(AppRouter.cart.name,
                queryParameters: {'from': currentRoute.toString()});
          } else {
            context.goNamed(AppRouter.favorites.name);
          }
        },
      ),
    );
  }
}

void showToast({
  required String message,
  Color backgroundColor = Colors.white,
  Color borderColor = Colors.grey, // Default border color
  BorderStyle borderStyle = BorderStyle.solid,
  double borderWidth = 0,
  double elevation = 4.0,
  Duration duration = const Duration(seconds: 2),
  TextStyle textStyle = const TextStyle(color: Colors.black),
  Icon? icon,
}) {
  Widget toast = Padding(
    padding: const EdgeInsets.symmetric(vertical: 64),
    child: Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(25.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: borderWidth,
            style: borderStyle,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: icon,
              ),
            Flexible(
              child: Text(
                message,
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: duration,
  );
}
