extension PriceExtension on num {
  String get formattedPrice {
    return '\$${toStringAsFixed(2)}';
  }
}

extension DoublePriceExtension on double {
  String get formattedPrice {
    return '\$${toStringAsFixed(2)}';
  }
}