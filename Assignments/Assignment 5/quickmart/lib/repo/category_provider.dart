import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:quickmart/extension/dio_extension.dart';

class CategoryRepository {
  final Dio _dio = Dio();
  final List<String> _categories = [];

  // Method to fetch categories asynchronously
  Future<List<String>> fetchCategories() async {
    if (_categories.isNotEmpty) {
      return _categories;
    }

    final response =
        await _dio.get('https://quickmart.codedbyyou.com/api/categories');
    if (response.isOk) {
      final categories = response.data as List;
      _categories.addAll(categories.map((e) => e.toString()));
      print('Fetched categories: $_categories');
      return _categories;
    } else {
      //use bundle on failure as call back for now
      print('Failed to fetch categories. Using local data');
      final categoriesJson = await rootBundle.loadString('assets/categories.json');
      final categories = json.decode(categoriesJson) as List;
      _categories.addAll(categories.map((e) => e.toString()));
    }

    return _categories;
  }
}
