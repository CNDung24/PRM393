import 'dart:convert';
import 'package:flutter/material.dart';
import 'Product.dart';

void main() {
  print('=== DEMO PRODUCT OPERATIONS ===\n');

  Product.displayAll();

  print('--- Test Add ---');
  Product.add(Product(id: 'P006', name: 'Monitor', image: 'monitor.png', price: 299.99));
  Product.displayAll();

  print('--- Test Edit ---');
  Product.Edit('P001', name: 'Gaming Laptop', price: 1299.99);
  Product.displayAll();

  print('--- Test Search By Name ---');
  List<Product> searchResults = Product.SearchByName('phone');
  for (var p in searchResults) {
    print('Found: ${p.name} - \$${p.price}');
  }

  print('\n--- Test Search By Price Range ---');
  List<Product> priceResults = Product.SearchByPriceRange(100, 600);
  for (var p in priceResults) {
    print('Found: ${p.name} - \$${p.price}');
  }

  print('\n--- Test Find ---');
  Product? found = Product.Find('P003');
  if (found != null) {
    print('Found: ${found.name} - \$${found.price}');
  }

  print('\n--- Test increasePrice 10% ---');
  Product.increasePrice(10);
  Product.displayAll();

  print('--- Test Factory fromJson ---');
  String jsonString = '{"id":"P007","name":"Tablet","image":"tablet.png","price":449.99}';
  Product tablet = Product.fromJson(jsonDecode(jsonString));
  print('From JSON: ${tablet.name} - \$${tablet.price}');

  print('\n=== ALL TESTS COMPLETED ===');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PRM Lab 1',
      home: Scaffold(
        appBar: AppBar(title: const Text('PRM Lab 1 - Product Demo')),
        body: const Center(
          child: Text('Check console for product operations output'),
        ),
      ),
    );
  }
}