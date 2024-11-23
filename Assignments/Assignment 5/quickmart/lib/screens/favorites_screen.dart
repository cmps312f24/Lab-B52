import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/providers/cart_provider.dart';
import 'package:quickmart/providers/favorites_provider.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
   @override
  Widget build(BuildContext context) {
    final productsAsyncValue = ref.watch(favoriteProviderNotifier);
    final cartAsyncValue = ref.watch(cartProviderNotifier);
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Favorites',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              productsAsyncValue.when(
                data: (products) {
                  return ElevatedButton(
                    onPressed: () {
                      ref
                          .read(cartProviderNotifier.notifier)
                          .addAllProductsToCart(products);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.add_shopping_cart),
                        SizedBox(width: 8.0),
                        Text('Add all to cart'),
                      ],
                    ),
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace) => const SizedBox(),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: productsAsyncValue.when(
              data: (products) {
                if (products.isEmpty) {
                  return const Center(
                    child: Text('No favorites yet'),
                  );
                }
                return cartAsyncValue.when(
                  data: (cartState) {
                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return buildListItem(
                          product,
                          cartState.getQuantity(product.id),
                        );
                      },
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, stackTrace) {
                    return ElevatedButton(
                      onPressed: () {
                        final _ = ref.refresh(favoriteProviderNotifier);
                      },
                      child: const Center(
                        child: Text('Failed to load favorites'),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) {
                return ElevatedButton(
                  onPressed: () {
                    final _ = ref.refresh(favoriteProviderNotifier); 
                  },
                  child: const Center(
                    child: Text('Failed to load favorites'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListItem(Product product, int productCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    product.imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 8.0), // Space between image and text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              product.title.length > 15
                                  ? '${product.title.substring(0, 15)}...'
                                  : product.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.favorite),
                              color: Colors.red,
                              onPressed: () {
                                ref
                                    .read(favoriteProviderNotifier.notifier)
                                    .toggleFavorite(product);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Row(
                      children: [
                        // need empty size book inside of the image
                        const SizedBox(
                          width: 65,
                          height: 0,
                        ),
                        Text(
                          '\$${product.price}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (productCount == 0)
                      GestureDetector(
                        onTap: () {
                          ref
                              .read(cartProviderNotifier.notifier)
                              .addProductToCart(product);
                        },
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey.shade50,
                          child: const Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 22,
                          ),
                        ),
                      ),
                    if (productCount > 0)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          color: Colors.grey.shade50,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  ref
                                      .read(cartProviderNotifier.notifier)
                                      .removeProductFromCart(product);
                                },
                                icon: Icon(
                                  Icons.remove,
                                ),
                              ),
                              Text(
                                productCount.toString(),
                                style: TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                onPressed: () {
                                  ref
                                      .read(cartProviderNotifier.notifier)
                                      .addProductToCart(product);
                                },
                                icon: Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
