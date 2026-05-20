import 'package:flutter/material.dart';
import 'models/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PRM Lab 1',
      home: ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sach san pham'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Tim kiem theo ten',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _searchByName(_searchController.text),
                ),
              ),
              onSubmitted: _searchByName,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Product.products.length,
              itemBuilder: (context, index) {
                var p = Product.products[index];
                return ListTile(
                  leading: const Icon(Icons.shopping_bag),
                  title: Text(p.name),
                  subtitle: Text('${p.image} - \$${p.price.toStringAsFixed(2)}'),
                  trailing: Text('ID: ${p.id}'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'add',
            onPressed: _showAddDialog,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'increase',
            onPressed: _increasePrice,
            child: const Icon(Icons.trending_up),
          ),
        ],
      ),
    );
  }

  void _searchByName(String name) {
    if (name.isEmpty) {
      setState(() {});
      return;
    }
    var results = Product.searchByName(name);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ket qua tim kiem'),
        content: SizedBox(
          width: double.maxFinite,
          child: results.isEmpty
              ? const Text('Khong tim thay san pham nao!')
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    var p = results[index];
                    return ListTile(
                      title: Text(p.name),
                      subtitle: Text('\$${p.price}'),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Dong'),
          ),
        ],
      ),
    );
  }

  void _showAddDialog() {
    final idController = TextEditingController();
    final nameController = TextEditingController();
    final imageController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Them san pham'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: idController, decoration: const InputDecoration(labelText: 'ID')),
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Ten')),
            TextField(controller: imageController, decoration: const InputDecoration(labelText: 'Image')),
            TextField(controller: priceController, decoration: const InputDecoration(labelText: 'Gia')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Product.add(Product(
                id: int.parse(idController.text),
                name: nameController.text,
                image: imageController.text,
                price: double.parse(priceController.text),
              ));
              setState(() {});
              Navigator.pop(context);
            },
            child: const Text('Them'),
          ),
        ],
      ),
    );
  }

  void _increasePrice() {
    Product.increasePrice();
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Da tang gia 10%!')),
    );
  }
}