import 'package:quickmart/models/cart_item.dart';

class Cart {
  final List<CartItem> _items;

  Cart(this._items);

  int getQuantity(String productId) {
    return _items.firstWhere((item) => item.id == productId, orElse: CartItem.empty).quantity;
  }

  double getTotalPrice() {
    return _items.fold(0, (total, item) => total + item.calculateTotalPrice());
  }

  List<CartItem> get items => _items;
}
