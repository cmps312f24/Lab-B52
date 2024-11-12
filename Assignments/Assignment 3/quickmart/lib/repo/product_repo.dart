import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/models/search_filter.dart';

class ProductRepo {
  bool _loaded = false;
  final Logger _logger = Logger('ProductRepo');
  bool loaded = false;
  final List<Product> _products = [];

  Future<List<Product>> loadRepo() async {
    if (_loaded) return _products;
    String content = await rootBundle.loadString('assets/data/products.json');
    List<dynamic> json = jsonDecode(content);
    _products.addAll(json.map((e) => Product.fromJson(e)).toList());
    _loaded = true;
    _logger.info("Products loaded: ${_products.length}");
    return _products;
  }

  Product getProductById(String id) {
    return _products.firstWhere((element) => element.id == id);
  }

  List<Product> filterProducts(SearchFilters filters) {
    return _products.where((product) {
      final matchesSearch = filters.searchText.isEmpty ||
          product.title.contains(filters.searchText) ||
          product.description.contains(filters.searchText);
      final matchesCategories = filters.categories.isEmpty ||
          filters.categories.contains(product.category);
      final matchesPrice =
          (filters.minPrice == null || product.price >= filters.minPrice!) &&
              (filters.maxPrice == null || product.price <= filters.maxPrice!);
      final matchesRating = (filters.minRating == null ||
              product.rating >= filters.minRating!) &&
          (filters.maxRating == null || product.rating <= filters.maxRating!);

      return matchesSearch &&
          matchesCategories &&
          matchesPrice &&
          matchesRating;
    }).toList();
  }
}

final productRepo = ProductRepo();
