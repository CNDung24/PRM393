class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final double discountPercent;
  final String image;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discountPercent,
    required this.image,
  });

  double get discountedPrice => price * (1 - discountPercent / 100);
}
