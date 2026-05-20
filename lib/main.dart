import 'dart:io';
import 'models/product.dart';

List<Product> products = [
  Product(id: 1, name: 'Ao thun', image: 'ao_thun.png', price: 150000),
  Product(id: 2, name: 'Quan jean', image: 'quan_jean.png', price: 350000),
  Product(id: 3, name: 'Giay the thao', image: 'giay.png', price: 500000),
  Product(id: 4, name: 'Mu luoi trai', image: 'mu.png', price: 80000),
  Product(id: 5, name: 'Tui xach', image: 'tui_xach.png', price: 250000),
];

void main() {
  while (true) {
    print('\n=== MENU ===');
    print('1. Hien thi danh sach san pham');
    print('2. Them san pham moi');
    print('3. Sua san pham');
    print('4. Tim kiem theo ten');
    print('5. Tim theo id');
    print('6. Tang gia 10%');
    print('0. Thoat');
    print('Nhap lua chon: ');

    String? input = stdin.readLineSync();
    int? choice = int.tryParse(input ?? '');

    switch (choice) {
      case 1:
        displayProducts();
        break;
      case 2:
        addProduct();
        break;
      case 3:
        editProduct();
        break;
      case 4:
        searchByName();
        break;
      case 5:
        findById();
        break;
      case 6:
        increasePrice();
        break;
      case 0:
        print('Ket thuc!');
        return;
      default:
        print('Lua chon khong hop le!');
    }
  }
}

void displayProducts() {
  if (products.isEmpty) {
    print('Danh sach trong!');
    return;
  }
  for (var p in products) {
    print('${p.id} - ${p.name} - ${p.image} - ${p.price}(VND)');
  }
}

void addProduct() {
  print('Nhap id: ');
  int id = int.parse(stdin.readLineSync()!);
  print('Nhap ten: ');
  String name = stdin.readLineSync()!;
  print('Nhap image: ');
  String image = stdin.readLineSync()!;
  print('Nhap gia: ');
  double price = double.parse(stdin.readLineSync()!);

  products.add(Product(id: id, name: name, image: image, price: price));
  print('Da them san pham!');
}

void editProduct() {
  print('Nhap id san pham can sua: ');
  int id = int.parse(stdin.readLineSync()!);
  int index = products.indexWhere((p) => p.id == id);
  if (index == -1) {
    print('Khong tim thay san pham!');
    return;
  }

  Product existing = products[index];
  print('Nhap ten moi (hien tai: ${existing.name}): ');
  String name = stdin.readLineSync()!;
  print('Nhap image moi (hien tai: ${existing.image}): ');
  String image = stdin.readLineSync()!;
  print('Nhap gia moi (hien tai: ${existing.price}): ');
  double price = double.parse(stdin.readLineSync()!);

  products[index] = Product(id: id, name: name, image: image, price: price);
  print('Da sua san pham!');
}

void searchByName() {
  print('Nhap ten can tim: ');
  String name = stdin.readLineSync()!;
  var results = products
      .where((p) => p.name.toLowerCase().contains(name.toLowerCase()))
      .toList();
  if (results.isEmpty) {
    print('Khong tim thay san pham nao!');
  } else {
    for (var p in results) {
      print('${p.id} - ${p.name} - ${p.image} - ${p.price}(VND)');
    }
  }
}

void findById() {
  print('Nhap id can tim: ');
  int id = int.parse(stdin.readLineSync()!);
  try {
    var product = products.firstWhere((p) => p.id == id);
    print(
      '${product.id} - ${product.name} - ${product.image} - ${product.price}(VND)',
    );
  } catch (e) {
    print('Khong tim thay san pham!');
  }
}

void increasePrice() {
  products = products
      .map(
        (p) => Product(
          id: p.id,
          name: p.name,
          image: p.image,
          price: p.price * 1.1,
        ),
      )
      .toList();
  print('Danh sach sau khi tang gia 10%:');
  for (var p in products) {
    print('${p.id} - ${p.name} - ${p.price.toStringAsFixed(2)}(VND)');
  }
}
