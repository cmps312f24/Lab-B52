import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/cart.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/repo/cart_repo.dart';

class CartProvider extends Notifier<Cart> {
  final CartRepository _cartRepo;

  CartProvider(this._cartRepo) : super();

  @override
  Cart build() {
    return Cart(_cartRepo.getCartItems());
  }

  bool isProductInCart(Product product) {
    return _cartRepo.isProductInCart(product);
  }

  void addProductToCart(Product product) {
    _cartRepo.addProduct(product);
    state = Cart(_cartRepo.getCartItems());
  }

  void removeProductFromCart(Product product) {
    _cartRepo.removeProduct(product);
    state = Cart(_cartRepo.getCartItems());
  }

  void clearCart() {
    _cartRepo.clearCart();
    state = Cart([]);
  }

  double getTotalPrice() {
    return _cartRepo.getTotalPrice();
  }

  int getProductQuantity(String productId) {
    return state.getQuantity(productId);
  }

  void addAllProductsToCart(List<Product> products) {
    products.forEach(_cartRepo.addProduct);
    state = Cart(_cartRepo.getCartItems());
  }
}

final cartProviderNotifier =
    NotifierProvider<CartProvider, Cart>(() => CartProvider(cartRepository));
