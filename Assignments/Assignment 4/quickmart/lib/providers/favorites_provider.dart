import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/repo/favorite_repo.dart';

/// A provider that manages the favorite products asynchronously
class FavoriteProvider extends AsyncNotifier<List<Product>> {
  final FavoritesRepository repository;

  FavoriteProvider(this.repository);

  @override
  Future<List<Product>> build() async {
    return await _loadFavorites();
  }

  Future<List<Product>> _loadFavorites() async {
    try {
      final favorites = await repository.getFavorites();
      return favorites;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return []; 
    }
  }

  Future<bool> toggleFavorite(Product product) async {
    try {
      isProductFavorite(product.id) ? await repository.removeFavorite(product.id) : await repository.addFavorite(product.id);
      state = AsyncValue.data(await _loadFavorites());
      return isProductFavorite(product.id);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return isProductFavorite(product.id);
    }
  }

  // In the shared favorite, its better to use a GET request to check if the product is already in the favorite list
  // However, in real world scenario the favorite list will be stored in the user's device and the user will be able to add or remove products from the favorite list
  // just the changes will be sent to the server to update the favorite list.
  // for now i am doing the real world scenario in the favorite list, because i provided a favoriteId to make it a unique favorite list for each key id.
  bool isProductFavorite(String id) {
    return state.maybeWhen(
      data: (value) => value.any((element) => element.id == id),
      orElse: () => false,
    );
  }
}

final favoriteProviderNotifier = AsyncNotifierProvider<FavoriteProvider, List<Product>>(
  () => FavoriteProvider(FavoritesRepository() ),
);
