class CartItem{
  final String id, name, imageUrl, category;
  final double unitPrice;


  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.unitPrice,
    required this.quantity,
    required this.imageUrl,
    required this.category,
  });

  CartItem.empty()
      : id = "",
        name = "",
        unitPrice = 0,
        quantity = 0,
        imageUrl = "",
        category = "";

  calculateTotalPrice() => unitPrice * quantity;
}
