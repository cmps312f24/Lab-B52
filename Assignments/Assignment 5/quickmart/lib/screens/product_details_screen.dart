import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/providers/cart_provider.dart';
import 'package:quickmart/providers/favorites_provider.dart';
import 'package:quickmart/providers/product_provider.dart';
import 'package:quickmart/providers/title_provider.dart';
import 'package:quickmart/screens/shell_screen.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final String productId;
  const ProductDetailsScreen({super.key, required this.productId});

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  bool isDetailsExpanded = false;

  @override
  Widget build(BuildContext context) {
    final product = ref
        .watch(productProviderNotifier.notifier)
        .getProductById(widget.productId.toString());

    final favoriteState = ref.watch(favoriteProviderNotifier);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.grey[100],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            context.pop();
            ref
                .watch(appTitleNotifierProvider.notifier)
                .updateTitle('QuickMart');
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.ios_share),
              color: Colors.black,
              onPressed: () {
                // share product
              },
            ),
          ),
        ],
      ),
      body: ClipRRect(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Container(
                color: Colors.grey[100],
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.asset(
                        product.imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 7.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              width: 4 * 4,
                              height: 4,
                              color: Colors.blue,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              width: 4 * 1,
                              height: 4,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              width: 4 * 2,
                              height: 4,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            favoriteState.when(
              data: (favorites) {
                var favorite =
                    favorites.any((element) => element.id == product.id);
                final cartState = ref.watch(cartProviderNotifier);
                final inCartQuantity = cartState.maybeWhen(
                  data: (cart) => cart.getQuantity(product.id),
                  orElse: () => 0,
                );
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                      bottom: 20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Text(
                                    product.title,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    var result = ref
                                        .watch(
                                            favoriteProviderNotifier.notifier)
                                        .toggleFavorite(product);
                                    result.then((value) {
                                      if (value) {
                                        showToast(
                                            message:
                                                'Product added to favorites');
                                      } else {
                                        showToast(
                                            message:
                                                'Product removed from favorites');
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    favorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: favorite ? Colors.red : Colors.grey,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                    ["Fruit", 'Vegetable', "Meat", "Vegan"]
                                            .contains(product.category)
                                        ? '1kg. Price'
                                        : 'Box. Price',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            buildProductCartCounter(product, inCartQuantity)
                          ],
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(),
                                Row(
                                  children: [
                                    const Text(
                                      'Product Detail',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isDetailsExpanded =
                                              !isDetailsExpanded;
                                        });
                                      },
                                      color: Colors.black,
                                      iconSize: 24,
                                      icon: Icon(
                                        isDetailsExpanded
                                            ? Icons.expand_less
                                            : Icons.expand_more,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                if (isDetailsExpanded)
                                  Text(
                                    product.description,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 5,
                                  ),
                                const SizedBox(height: 15),
                                const Divider(),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      'Nutritions',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical:
                                                  6), // Adjust the padding as needed
                                          decoration: BoxDecoration(
                                            color: Colors.grey[
                                                300], // Background color if you want to use it here
                                            borderRadius: BorderRadius.circular(
                                                8), // Optional: for rounded corners
                                          ),
                                          child: Text(
                                            '100g',
                                            style: const TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            // Show nutrition
                                          },
                                          color: Colors.black,
                                          iconSize: 24,
                                          icon: const Icon(Icons.chevron_right),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                const Divider(),
                                // review
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    Text(
                                      'Reviews',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    // 5 star rating
                                    Row(
                                      children: [
                                        for (var i = 0; i < product.rating; i++)
                                          const Icon(
                                            Icons.star,
                                            color: Colors.orange,
                                          ),
                                        for (var i = 0;
                                            i < 5 - product.rating;
                                            i++)
                                          const Icon(
                                            Icons.star,
                                            color: Colors.grey,
                                          ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        // Show reviews
                                      },
                                      color: Colors.black,
                                      iconSize: 24,
                                      icon: const Icon(Icons.chevron_right),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Add To Basket Big Button
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (inCartQuantity == 0) {
                                  showToast(
                                    message:
                                        'Product added to cart, you can modify the quantity above',
                                  );
                                  ref
                                      .watch(cartProviderNotifier.notifier)
                                      .addProductToCart(product, quantity: 1);
                                } else {
                                  context.pop();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                inCartQuantity == 0
                                    ? 'Add to Cart'
                                    : 'In Basket',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              error: (error, stack) {
                return Center(
                  child: Text('Error: $error'),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Row buildProductCartCounter(Product product, int cartCount) {
    if (cartCount == 0) {
      return Row(
        children: [
          GestureDetector(
            onTap: () {
              ref
                  .watch(cartProviderNotifier.notifier)
                  .addProductToCart(product);
            },
            child: Row(
              children: [
                Text(
                  'Add',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                    width: 8), // Add some spacing between text and icon
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.add,
                    color: Colors.blue,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            '\$${product.price}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        Row(children: [
          IconButton(
            onPressed: () {
              ref
                  .watch(cartProviderNotifier.notifier)
                  .removeProductFromCart(product);
            },
            iconSize: 26,
            color: Colors.grey.shade600,
            icon: const Icon(Icons.remove),
          ),
          Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(1), // Add padding for spacing
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey.shade300), // Set the border color
              borderRadius:
                  BorderRadius.circular(16.0), // Optional: rounded corners
              color: Colors.white, // Optional: background color
            ),
            child: Center(
              // Center the text inside the container
              child: Text(
                cartCount.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              ref
                  .watch(cartProviderNotifier.notifier)
                  .addProductToCart(product);
            },
            iconSize: 26,
            color: Colors.blue.shade600,
            icon: const Icon(Icons.add),
          ),
        ]),
        const Spacer(),
        Text(
          '\$${product.price}',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
