import 'package:quickmart/models/cart_item.dart';
import 'package:quickmart/models/product.dart';

class CartRepository {
  final List<CartItem> _cart = [];

  List<CartItem> getCartItems() {
    return _cart;
  }

  void addProduct(Product product) {
    if (_cart.any((element) => element.id == product.id)) {
      _cart.firstWhere((element) => element.id == product.id).quantity++;
    } else {
      _cart.add(CartItem(
        id: product.id,
        name: product.title,
        unitPrice: product.price,
        quantity: 1,
        imageUrl: product.imageUrl,
        category: product.category,
      ));
    }
  }

  void removeProduct(Product product) {
    if (_cart.any((element) => element.id == product.id)) {
      var cartItem = _cart.firstWhere((element) => element.id == product.id);
      if (cartItem.quantity > 1) {
        cartItem.quantity--;
      } else {
        _cart.remove(cartItem);
      }
    }
  }

  void hardRemoveProduct(Product product) {
    _cart.remove(product);
  }

  void clearCart() {
    _cart.clear();
  }

  double getTotalPrice() {
    return _cart.fold(0, (total, item) => total + item.calculateTotalPrice());
  }

  bool isProductInCart(Product product) {
    return _cart.any((element) => element.id == product.id);
  }

  int getProductQuantity(Product product) {
    return _cart.firstWhere((element) => element.id == product.id).quantity;
  }
}

final cartRepository = CartRepository();
