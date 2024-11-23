class SearchFilters {
  final String searchText;
  final List<String> categories; 
  final int? minPrice, maxPrice;
  final int? minRating, maxRating;

  SearchFilters({
    this.searchText = '',
    this.categories = const [], 
    this.minPrice,
    this.maxPrice,
    this.minRating,
    this.maxRating,
  });

  // its a record class, so we need to override every time we want to change a value
  SearchFilters copyWith({
    String? searchText,
    List<String>? categories,
    int? minPrice,
    int? maxPrice,
    int? minRating,
    int? maxRating,
  }) {
    return SearchFilters(
      searchText: searchText ?? this.searchText,
      categories: categories ?? this.categories,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minRating: minRating ?? this.minRating,
      maxRating: maxRating ?? this.maxRating,
    );
  }
}
