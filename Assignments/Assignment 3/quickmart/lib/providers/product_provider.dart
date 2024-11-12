import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/models/search_filter.dart';
import 'package:quickmart/repo/product_repo.dart';

class ProductProvider extends Notifier<List<Product>> {
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
      state = value;
    });
  }

  Product getProductById(String id) {
    return _productRepo.getProductById(id);
  }

  void filterProducts(SearchFilters filters) {
    state = productRepo.filterProducts(filters);
  }
  
}

final productProviderNotifier = NotifierProvider<ProductProvider, List<Product>>(() => ProductProvider());
  