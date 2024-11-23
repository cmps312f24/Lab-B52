import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/repo/category_provider.dart';


final categoryProvider = StateNotifierProvider<CategoryNotifier, List<String>>((ref) {
  final categoryRepository = CategoryRepository();
  return CategoryNotifier(categoryRepository);
});

class CategoryNotifier extends StateNotifier<List<String>> {
  final CategoryRepository _categoryRepository;

  CategoryNotifier(this._categoryRepository) : super([]) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    final categories = await _categoryRepository.fetchCategories();
    state = categories;
  }
}