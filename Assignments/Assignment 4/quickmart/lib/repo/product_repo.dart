import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:quickmart/extension/dio_extension.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/models/search_filter.dart';

class ProductRepo {
  final Logger _logger = Logger('ProductRepo');
  final Dio _dio = Dio();
  final String _baseUrl = 'https://quickmart.codedbyyou.com/api/products';
  bool _loaded = false;
  final List<Product> _products = [];

  Future<List<Product>> loadRepo() async {
    if (_loaded) return _products;

    try {
      final response = await _dio.get(_baseUrl);
      if (response.isOk) { // We can also use (response.statusCode == 200)
        List<dynamic> json = response.data;
        _products.clear();
        _products.addAll(json.map((e) => Product.fromJson(e)).toList());
        _loaded = true;
        _logger.info("Products loaded: ${_products.length}");
      } else {
        _logger.warning("Failed to load products. Status code: ${response.statusCode}");
      }
    } catch (e) {
      _logger.severe("Error loading products: $e");
    }

    return _products;
  }

  Product getProductById(String id) {
    if (_loaded) {
      return _products.firstWhere((element) => element.id == id, orElse: () => Product.empty());
    }
    _logger.warning("Products not loaded yet. Call loadRepo() first.");
    return Product.empty();
  }

  Future<List<Product>> filterProducts(SearchFilters filters) async {
    final Map<String, dynamic> queryParams = {
      'name': filters.searchText.isNotEmpty ? filters.searchText : null,
      'category': filters.categories.isNotEmpty ? filters.categories.join(',') : null,
      'minPrice': filters.minPrice,
      'maxPrice': filters.maxPrice,
      'minRating': filters.minRating,
      'maxRating': filters.maxRating,
    }..removeWhere((key, value) => value == null || (value is int? && key.contains("Price") && value! == 0)); // Remove null values from the query map and 0 values for price

    try {
      final response = await _dio.get(
        '$_baseUrl/search',
        queryParameters: queryParams,
      );
      if (response.isOk) {
        List<dynamic> json = response.data;
        return json.map((e) => Product.fromJson(e)).toList();
      } else {
        _logger.warning("Failed to search products. Status code: ${response.statusCode}");
      }
    } catch (e) {
      _logger.severe("Error searching products: $e");
    }
    return [];
  }
}

final productRepo = ProductRepo();
