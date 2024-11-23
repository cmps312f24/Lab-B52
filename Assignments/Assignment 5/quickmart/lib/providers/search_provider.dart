import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickmart/models/search_filter.dart';


class SearchProvider extends Notifier<SearchFilters> {
  SearchProvider() : super();

  @override
  SearchFilters build() {
    return SearchFilters();
  }

  SearchFilters setSearchText(String text) {
    text = text.trim();
    if (text == state.searchText) return state;
    state = state.copyWith(searchText: text);
    return state;
  }

  SearchFilters toggleCategory(String category) {
    final categories = List<String>.from(state.categories);
    if (categories.contains(category)) {
      categories.remove(category);
    } else {
      categories.add(category);
    }
    state = state.copyWith(categories: categories);
    return state;
  }


  SearchFilters setPriceRange(int? minPrice, int? maxPrice) {
    state = state.copyWith(minPrice: minPrice, maxPrice: maxPrice);
    // String x = 1;
    return state;
  }

  SearchFilters setRatingRange(int? minRating, int? maxRating) {
    state = state.copyWith(minRating: minRating, maxRating: maxRating);
    return state;
  }

  SearchFilters applyFilters(SearchFilters filters) {
    state = filters;
    return state;
  }

  SearchFilters clearFilters() {
    state = SearchFilters(); 
    return state;
  }
}


final searchProviderNotifier = NotifierProvider<SearchProvider, SearchFilters>(() => SearchProvider());