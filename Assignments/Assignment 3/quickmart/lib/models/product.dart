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


}