class Product {
  final String id;
  final String name;
  final String image;
  double price;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
    };
  }

  static List<Product> products = [
    Product(id: 'P001', name: 'Laptop', image: 'laptop.png', price: 999.99),
    Product(id: 'P002', name: 'Smartphone', image: 'phone.png', price: 599.99),
    Product(id: 'P003', name: 'Headphones', image: 'headphones.png', price: 149.99),
    Product(id: 'P004', name: 'Keyboard', image: 'keyboard.png', price: 79.99),
    Product(id: 'P005', name: 'Mouse', image: 'mouse.png', price: 39.99),
  ];

  static void add(Product product) {
    products.add(product);
    print('Added: ${product.name}');
  }

  static bool Edit(String id, {String? name, String? image, double? price}) {
    int index = products.indexWhere((p) => p.id == id);
    if (index != -1) {
      products[index] = Product(
        id: id,
        name: name ?? products[index].name,
        image: image ?? products[index].image,
        price: price ?? products[index].price,
      );
      print('Edited: ${products[index].name}');
      return true;
    }
    return false;
  }

  static List<Product> SearchByName(String keyword) {
    return products.where((p) => p.name.toLowerCase().contains(keyword.toLowerCase())).toList();
  }

  static List<Product> SearchByPriceRange(double min, double max) {
    return products.where((p) => p.price >= min && p.price <= max).toList();
  }

  static List<Product> SearchById(String id) {
    return products.where((p) => p.id == id).toList();
  }

  static Product? Find(String id) {
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  static void increasePrice(double percent) {
    products = products.map((p) => Product(
      id: p.id,
      name: p.name,
      image: p.image,
      price: p.price * (1 + percent / 100),
    )).toList();
    print('All prices increased by $percent%');
  }

  static void displayAll() {
    print('\n=== Product List ===');
    for (var p in products) {
      print('ID: ${p.id}, Name: ${p.name}, Image: ${p.image}, Price: \$${p.price.toStringAsFixed(2)}');
    }
    print('===================\n');
  }
}