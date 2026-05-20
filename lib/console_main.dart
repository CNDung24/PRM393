import 'dart:io';
import 'models/product.dart';

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
  if (Product.products.isEmpty) {
    print('Danh sach trong!');
    return;
  }
  for (var p in Product.products) {
    print('${p.id} - ${p.name} - ${p.image} - \$${p.price}');
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

  Product.add(Product(id: id, name: name, image: image, price: price));
  print('Da them san pham!');
}

void editProduct() {
  print('Nhap id san pham can sua: ');
  int id = int.parse(stdin.readLineSync()!);
  Product? existing = Product.findById(id);
  if (existing == null) {
    print('Khong tim thay san pham!');
    return;
  }

  print('Nhap ten moi (hien tai: ${existing.name}): ');
  String name = stdin.readLineSync()!;
  print('Nhap image moi (hien tai: ${existing.image}): ');
  String image = stdin.readLineSync()!;
  print('Nhap gia moi (hien tai: ${existing.price}): ');
  double price = double.parse(stdin.readLineSync()!);

  Product.edit(Product(id: id, name: name, image: image, price: price));
  print('Da sua san pham!');
}

void searchByName() {
  print('Nhap ten can tim: ');
  String name = stdin.readLineSync()!;
  var results = Product.searchByName(name);
  if (results.isEmpty) {
    print('Khong tim thay san pham nao!');
  } else {
    for (var p in results) {
      print('${p.id} - ${p.name} - ${p.image} - \$${p.price}');
    }
  }
}

void findById() {
  print('Nhap id can tim: ');
  int id = int.parse(stdin.readLineSync()!);
  var product = Product.findById(id);
  if (product == null) {
    print('Khong tim thay san pham!');
  } else {
    print('${product.id} - ${product.name} - ${product.image} - \$${product.price}');
  }
}

void increasePrice() {
  var increased = Product.increasePrice();
  print('Danh sach sau khi tang gia 10%:');
  for (var p in increased) {
    print('${p.id} - ${p.name} - \$${p.price.toStringAsFixed(2)}');
  }
}