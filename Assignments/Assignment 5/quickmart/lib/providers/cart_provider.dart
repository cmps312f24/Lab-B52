import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/cart.dart';
import 'package:quickmart/models/cart_item.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/repo/cart_repo.dart';


// Everywhere in here, i am updating the state of the cart to reflect the changes in the cart items visually first before updating the database.
// This is because if we update the databse and show the loading spinner, the user might think the app is slow or not responding.
// So, we update the state first and then update the database. If the database update fails, we can revert the state back to the previous state
// Or fetch the cart items from the database again to reflect the changes in the cart items like it rolled back.
// This is a good practice to follow in your app to make it more responsive and user friendly.
class CartProvider extends AsyncNotifier<Cart> {
  final CartRepository _cartRepo;

  // Constructor to initialize the repository
  CartProvider(this._cartRepo);

  // Load cart items asynchronously
  @override
  Future<Cart> build() async {
    try {
      final cartItems = await _cartRepo.getCartItems();
      return Cart(cartItems);
    } catch (e) {
      print(e);
      return Cart([]);
    }
  }

  // Add a product to the cart asynchronously and refresh the state
  Future<void> addProductToCart(Product product, {int quantity = 1}) async { 
    try {
      final cart = state.maybeWhen(data: (cart) => cart, orElse: () => Cart([]));
      final items = cart.items;
      final index = items.indexWhere((item) => item.id == product.id);
      var currentQuantity = 0;
      if (index == -1) {
        items.add(
          CartItem(
            id: product.id,
            title: product.title,
            unitPrice: product.price,
            imageUrl: product.imageName,
            category: product.category,
            description: product.description,
            quantity: 1,
          ),
        );
         currentQuantity = 1;
         await _cartRepo.addProduct(product, currentQuantity );
      } else {
        items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
        currentQuantity = items[index].quantity;
        await _cartRepo.updateProductQuantity(product, currentQuantity);
      }
      state = AsyncValue.data(Cart(items));
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current); 
    }
  }

  Future<void> removeProductFromCart(Product product) async {
    // state = const AsyncValue.loading(); 
    try { 
      final cart = state.asData?.value;
      final items = cart?.items ?? [];
      final index = items.indexWhere((item) => item.id == product.id);
      final quantity = items[index].quantity;
      if (quantity > 1) {
        await _cartRepo.updateProductQuantity(product, quantity - 1);
        items[index] = items[index].copyWith(quantity: items[index].quantity - 1);
      } else {
        items.removeAt(index);
        await _cartRepo.removeProduct(product);
      }
      state = AsyncValue.data(Cart(items));
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> clearCart() async {
    state = const AsyncValue.loading(); 
    try {
      await _cartRepo.clearCart();
      // Simulating a delay to show the loading spinner for a fast loading process
      await Future.delayed(const Duration(milliseconds: 800));
      state = AsyncValue.data(Cart([])); 
    } catch (e) {
      state = AsyncValue.error(e , StackTrace.current);
    }
  }

  // Get the total price from the cart items
  double getTotalPrice() {
    return state.maybeWhen(data: (cart) => cart.getTotalPrice(), orElse: () => 0.0);
  }

  int getProductQuantity(String productId) {
    return state.maybeWhen(data: (cart) => cart.getQuantity(productId), orElse: () => 0);
  }

  // Add all products to the cart asynchronously
  Future<void> addAllProductsToCart(List<Product> products) async {
    try {
      final cartItems = state.maybeWhen(data: (cart) => cart.items, orElse: () => <CartItem>[]);
      for (var product in products) {
        final cartItemIndex = cartItems.indexWhere((item) => item.id == product.id);
        final currentQuantity = cartItemIndex == -1 ? 0 : cartItems[cartItemIndex].quantity;
        if (cartItemIndex == -1) {
          cartItems.add(
            CartItem(
              id: product.id,
              title: product.title,
              unitPrice: product.price,
              imageUrl: product.imageName,
              category: product.category,
              description: product.description,
              quantity: 1,
            ),
          );
        } else {
          cartItems[cartItemIndex] = cartItems[cartItemIndex].copyWith(quantity: currentQuantity + 1);
        }

        await _cartRepo.addProduct(product, currentQuantity + 1);
      }
      state = AsyncValue.data(Cart(cartItems));
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

}

final cartProviderNotifier = AsyncNotifierProvider<CartProvider, Cart>(() => CartProvider(cartRepository));
