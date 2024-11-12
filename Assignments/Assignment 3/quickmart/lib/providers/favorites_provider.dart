import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/product.dart';

/// A provider that manages the favorite products
/// The only reason i am dealing with the favorite this way is because
/// i am not using a database to store the favorite products or a repository
/// to manage the favorite products, else i would have used a repository to manage the favorite products
class FavoriteProvider extends Notifier<List<Product>> {
  FavoriteProvider() : super();

  @override
  List<Product> build() {
    return [];
  }

  bool toggleFavorite(Product product) {
    if (isProductFavorite(product.id)) {
      removeProductFromFavorites(product.id);
      return false;
    } else {
      addProductToFavorites(product);
      return true;
    }
  }

  void addProductToFavorites(Product product) {
    if (!state.any((element) => element.id == product.id)) {
      state = [...state, product];
    }
  }

  void removeProductFromFavorites(String id) {
    state = state.where((element) => element.id != id).toList();
  }

  List<Product> getFavoriteProducts() {
    return state;
  }

  bool isProductFavorite(String id) {
    return state.any((element) => element.id == id);
  }
}

final favoriteProviderNotifier =
    NotifierProvider<FavoriteProvider, List<Product>>(() => FavoriteProvider());
