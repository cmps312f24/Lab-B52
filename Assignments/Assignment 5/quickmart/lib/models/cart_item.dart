class CartItem{
  final String id, title, imageUrl, category, description;
  final double unitPrice;

  get assetImageUrl => "assets/images/$imageUrl";

  int quantity;
  CartItem({
    required this.id,
    required this.title,
    required this.unitPrice,
    required this.quantity,
    required this.imageUrl,
    required this.category,
    required this.description,
  });

  CartItem.empty()
      : id = "",
        title = "",
        unitPrice = 0,
        quantity = 0,
        imageUrl = "",
        category = "",
        description = "";

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      title: json['title'],
      unitPrice: json['price'],
      quantity: json['quantity'],
      imageUrl: json['imageName'],
      category: json['category'],
      description: json['description'],

    );
  }

  CartItem copyWith({
    String? id,
    String? title,
    double? unitPrice,
    int? quantity,
    String? imageUrl,
    String? category,
    String? description,
  }) {
    return CartItem(
      id: id ?? this.id,
      title: title ?? this.title,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      description: description ?? this.description,
    );
  }

  calculateTotalPrice() => unitPrice * quantity;
}
