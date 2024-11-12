import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

class CategoryRepository {
  final List<String> _categories = [];

  // Method to fetch categories asynchronously
  Future<List<String>> fetchCategories() async {
    if (_categories.isNotEmpty) {
      return _categories;
    }

    final categoriesJson =
        await rootBundle.loadString('assets/data/product-categories.json');
    final categories = json.decode(categoriesJson) as List;
    _categories.addAll(categories.map((e) => e.toString()));
    return _categories;
  }
}
