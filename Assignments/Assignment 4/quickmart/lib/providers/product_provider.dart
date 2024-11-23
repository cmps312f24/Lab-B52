import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/models/search_filter.dart';
import 'package:quickmart/repo/product_repo.dart';

class ProductProvider extends AsyncNotifier<List<Product>> {
  final ProductRepo _productRepo = productRepo;

  ProductProvider() : super();

  @override
  List<Product> build() {
    _loadProducts();
    return [];
  }

  void _loadProducts() {
    var products = _productRepo.loadRepo();
    products.then((value) {
      state = AsyncValue.data(value);
    });
  }

  Product getProductById(String id) {
    return _productRepo.getProductById(id);
  }

  Future<void> filterProducts(SearchFilters filters) async {
    try {
      state = const AsyncLoading(); // Notify listeners that we're loading
      final filteredProducts = await _productRepo.filterProducts(filters);
      state = AsyncValue.data(filteredProducts);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final productProviderNotifier = AsyncNotifierProvider<ProductProvider, List<Product>>(() => ProductProvider());
  