import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quickmart/extension/num_price_ext.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/providers/cart_provider.dart';
import 'package:quickmart/providers/favorites_provider.dart';
import 'package:quickmart/providers/product_provider.dart';
import 'package:quickmart/routes/app_router.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key});

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  List<int> productCounts = List.filled(50, 0);

  int minDebounceTime = 200;
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProviderNotifier);
    final ScrollController scrollController = ScrollController();
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              scrollController.animateTo(
                200,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Market',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Buy your favorite products at the best prices',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Products',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height *
                0.7, // Set a fixed height for the GridView
            child: buildList(context, products),
          ),
        ],
      ),
    );
  }

  GridView buildList(BuildContext context, List<Product> products) {
    final favorites = ref.watch(favoriteProviderNotifier);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (contextNew, index) {
        final product = products[index];
        final isInFavorite = favorites.contains(product);
        return MouseRegion(
          cursor: SystemMouseCursors.basic,
          onEnter: (event) => setState(() => _hoveredIndex = index),
          onExit: (event) => setState(() => _hoveredIndex = null),
          child: GestureDetector(
            onTap: () {
              context.pushNamed(AppRouter.productDetails.name,
                  pathParameters: {'id': product.id});
            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              child: Card(
                margin: const EdgeInsets.all(8.0),
                elevation: 0,
                color:
                    (_hoveredIndex == index) ? Colors.grey[50] : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12.0)),
                            child: Container(
                              color: Colors.grey[100],
                              child: AspectRatio(
                                aspectRatio: 19 / 16,
                                child: Image.asset(
                                  products[index].imageUrl,
                                  fit: BoxFit.contain,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 8.0,
                              left: 8.0,
                              child: buildProductCartCount(product)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${products[index].price.formattedPrice} USD',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 14,
                                ),
                              ),
                              const Spacer(),
                              // turn this into icon button
                              GestureDetector(
                                onTap: () {
                                  ref
                                      .watch(favoriteProviderNotifier.notifier)
                                      .toggleFavorite(product);
                                },
                                child: Icon(
                                  !isInFavorite
                                      ? Icons.favorite_border
                                      : Icons.favorite,
                                  size: 16,
                                  color:
                                      !isInFavorite ? Colors.grey : Colors.red,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            products[index].category,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 8,
                            ),
                          ),
                          Text(
                            products[index].title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: products.length,
    );
  }

  Widget buildProductCartCount(Product product) {
    final cartState = ref.watch(cartProviderNotifier);
    final productCount = cartState.getQuantity(product.id);
    if (productCount == 0) {
      return GestureDetector(
        onTap: () {
          ref.watch(cartProviderNotifier.notifier).addProductToCart(product);
        },
        child: CircleAvatar(
          radius: 16,
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            color: Colors.black,
            size: 16,
          ),
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        color: Colors.white,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                ref
                    .watch(cartProviderNotifier.notifier)
                    .removeProductFromCart(product);
              },
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.remove,
                  color: Colors.black,
                  size: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                productCount.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
            GestureDetector(
              onTap: () {
                ref
                    .watch(cartProviderNotifier.notifier)
                    .addProductToCart(product);
              },
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
