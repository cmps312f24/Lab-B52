import 'package:dio/dio.dart';
import 'package:quickmart/extension/dio_extension.dart';
import 'package:quickmart/models/product.dart';

class FavoritesRepository {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://quickmart.codedbyyou.com/api/favorites';
  FavoritesRepository();
  final String favoriteId = 'CodedByYou';

  Future<List<Product>> getFavorites() async {
    final response = await _dio.get(_baseUrl,queryParameters: {'fillInProducts': 'true', 'favoriteId': favoriteId});
    return (response.data as List)
        .map((json) => Product.fromJson(json))
        .toList();
  }

  Future<void> addFavorite(String productId) async {
    final response = await _dio.post(_baseUrl, data: {'productId': productId}, queryParameters: { 'favoriteId': favoriteId });  
    if (response.isNotCreated) {
      throw Exception('Failed to add product to favorites server responded with ${response.statusCode}');
    }
  }

  Future<void> removeFavorite(String productId) async {
    await _dio.delete('$_baseUrl/$productId', queryParameters: { 'favoriteId': favoriteId });
  }

  Future<Product?> getFavoriteById(String productId) async {
    final response = await _dio.get('$_baseUrl/$productId', queryParameters: { 'favoriteId': favoriteId });
    if (response.isOk) {
      return Product.fromJson(response.data);
    }
    return null;
  }
}
