import '../models/product.dart';

class ProductDao {
  final List<Product> _products = const [
    Product(
      id: 1,
      name: 'iPhone 15 Pro',
      description:
          'iPhone 15 Pro với chip A17 Pro, camera 48MP, thiết kế titan sang trọng. Màn hình Super Retina XDR 6.1 inch.',
      price: 1199,
      discountPercent: 5,
      image:
          'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400',
    ),
    Product(
      id: 2,
      name: 'MacBook Air M3',
      description:
          'MacBook Air với chip M3, màn hình Liquid Retina 13.6 inch, pin lên đến 18 giờ. Thiết kế mỏng nhẹ.',
      price: 1099,
      discountPercent: 10,
      image:
          'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400',
    ),
    Product(
      id: 3,
      name: 'AirPods Pro 2',
      description:
          'AirPods Pro thế hệ 2 với chip H2, chống ồn chủ động, âm thanh không gian. Pin lên đến 6 giờ.',
      price: 249,
      discountPercent: 15,
      image:
          'https://images.unsplash.com/photo-1606220588913-b3aacb4d2f46?w=400',
    ),
    Product(
      id: 4,
      name: 'iPad Air M2',
      description:
          'iPad Air với chip M2, màn hình Liquid Retina 11 inch, hỗ trợ Apple Pencil Pro. Phù hợp học tập và làm việc.',
      price: 799,
      discountPercent: 8,
      image:
          'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400',
    ),
    Product(
      id: 6,
      name: 'Samsung Galaxy S24 Ultra',
      description:
          'Galaxy S24 Ultra với chip Snapdragon 8 Gen 3, camera 200MP, S Pen tích hợp. Màn hình Dynamic AMOLED 2X.',
      price: 1299,
      discountPercent: 7,
      image:
          'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400',
    ),
    Product(
      id: 7,
      name: 'Sony WH-1000XM5',
      description:
          'Tai nghe chống ồn hàng đầu thế giới, âm thanh Hi-Res, pin 30 giờ. Thiết kế êm ái, nhẹ nhàng.',
      price: 349,
      discountPercent: 20,
      image:
          'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=400',
    ),
    Product(
      id: 8,
      name: 'Dell XPS 15',
      description:
          'Laptop ultrabook với chip Intel Core i7, màn hình OLED 15.6 inch, RAM 16GB. Thiết kế cao cấp.',
      price: 1299,
      discountPercent: 6,
      image:
          'https://images.unsplash.com/photo-1593642632559-0c6d3fc62b89?w=400',
    ),
  ];

  List<Product> getAllProduct() {
    return List.unmodifiable(_products);
  }

  List<Product> findProductByName(String name) {
    if (name.isEmpty) return getAllProduct();
    final query = name.toLowerCase();
    return _products
        .where((p) => p.name.toLowerCase().contains(query))
        .toList();
  }
}
