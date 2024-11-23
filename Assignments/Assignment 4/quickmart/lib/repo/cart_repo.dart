import 'package:dio/dio.dart';
import 'package:quickmart/extension/dio_extension.dart';
import 'package:quickmart/models/cart_item.dart';
import 'package:quickmart/models/product.dart';

class CartRepository {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://quickmart.codedbyyou.com/api/cart';
  final String cartId = 'CodedByYou';

  Future<List<CartItem>> getCartItems() async { 
    try {
      final response = await _dio.get(_baseUrl, queryParameters: {'fillInProducts': 'true' , 'cartId': cartId});
      if (response.isOk) { // 200, 201, 203, 204
        return (response.data as List)
            .map((json) => CartItem.fromJson(json))
            .toList();
      } else {
        throw Exception('Error, Failed to load cart items server responded with ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load cart items: $e');
    }
  }

  Future<void> addProduct(Product product, int quantity) async {
    if (quantity == 1 ){
      try {
        final response = await _dio.post(_baseUrl, data: {
          'productId': product.id,
          'quantity': quantity,
        },
          queryParameters: {'cartId': cartId},
        );
        if (response.isNotCreated) {
          throw Exception('Failed to add product to the cart, server responded with ${response.statusCode}');
        }
      } catch (e) {
        throw Exception('Failed to add product to the cart: $e');
      }
    } else {
      updateProductQuantity(product, quantity);
    }
  }

  Future<void> updateProductQuantity(Product product, int quantity) async {
    try {
      final response = await _dio.put('$_baseUrl/${product.id}', data: {
        'productId': product.id,
        'quantity': quantity,
      },
        queryParameters: {'cartId': cartId},
      );
      if (response.isNotSuccessful) {
        throw Exception('Failed to update product quantity server responded with ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update product quantity: $e');
    }
  }

  Future<void> removeProduct(Product product) async {
    try {
      final response = await _dio.delete('$_baseUrl/${product.id}',
        queryParameters: {'cartId': cartId},
      );
      if (response.failedNoContent) {
        throw Exception('Failed to remove product from the cart');
      }
    } catch (e) {
      throw Exception('Failed to remove product from the cart: $e');
    }
  }

  Future<void> clearCart() async {
    try {
      final response = await _dio.delete(_baseUrl, queryParameters: {'cartId': cartId});
      if (response.failedNoContent) {
        throw Exception('Failed to clear the cart');
      }
    } catch (e) {
      throw Exception('Failed to clear the cart: $e');
    }
  }

  double getTotalPrice(List<CartItem> cartItems) {
    return cartItems.fold(0, (total, item) => total + item.calculateTotalPrice());
  }
}

final cartRepository = CartRepository();