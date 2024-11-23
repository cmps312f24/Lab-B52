// {
//     "id": "QM-2024-SVDNM",
//     "title": "Brown eggs",
//     "category": "Dairy",
//     "description": "Raw organic brown eggs in a basket",
//     "price": 28.1,
//     "rating": 4,
//     "imageName": "brown_eggs.jpeg"
// }
class Product {
  final String id, title, category, description, imageName;
  final double price;
  final int rating;

  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.imageName,
    required this.price,
    required this.rating,
  });

  get imageUrl => "assets/images/$imageName";

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      description: json['description'],
      imageName:  json['imageName'],
      price: json['price'],
      rating: json['rating'],
    );
  }

  static Product empty() {
    return Product(
      id: '',
      title: '',
      category: '',
      description: '',
      imageName: '',
      price: 0,
      rating: 0,
    );
  }

  Product copyWith({
    String? id,
    String? title,
    String? category,
    String? description,
    String? imageName,
    double? price,
    int? rating,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      imageName: imageName ?? this.imageName,
      price: price ?? this.price,
      rating: rating ?? this.rating,
    );
  }
}