class Product {
  final int id;
  final String name;
  final String image;
  double price;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  static List<Product> products = [
    Product(id: 1, name: 'Laptop', image: 'laptop.png', price: 999.99),
    Product(id: 2, name: 'Smartphone', image: 'phone.png', price: 599.99),
    Product(id: 3, name: 'Headphones', image: 'headphones.png', price: 149.99),
    Product(id: 4, name: 'Keyboard', image: 'keyboard.png', price: 79.99),
    Product(id: 5, name: 'Mouse', image: 'mouse.png', price: 39.99),
  ];

  static void add(Product product) {
    products.add(product);
  }

  static void edit(Product product) {
    int index = products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      products[index] = product;
    }
  }

  static List<Product> searchByName(String name) {
    return products.where((p) => p.name.toLowerCase().contains(name.toLowerCase())).toList();
  }

  static Product? findById(int id) {
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<Product> increasePrice() {
    products = products.map((p) => Product(
      id: p.id,
      name: p.name,
      image: p.image,
      price: p.price * 1.1,
    )).toList();
    return products;
  }
}