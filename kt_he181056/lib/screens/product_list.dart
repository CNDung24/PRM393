import 'package:flutter/material.dart';
import '../dao/product_dao.dart';
import '../models/product.dart';
import 'product_detail.dart';

class ProductListScreen extends StatefulWidget {
  final ValueChanged<int>? onNavigate;

  const ProductListScreen({super.key, this.onNavigate});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductDao _productDao = ProductDao();
  final TextEditingController _searchController = TextEditingController();
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _products = _productDao.getAllProduct();
  }

  void _search(String query) {
    setState(() {
      _products = _productDao.findProductByName(query);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Tìm kiếm sản phẩm...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            onChanged: _search,
          ),
        ),
        Expanded(
          child: _products.isEmpty
              ? const Center(child: Text('Không tìm thấy sản phẩm'))
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final isPortrait =
                        MediaQuery.of(context).orientation ==
                            Orientation.portrait;

                    int crossAxisCount;
                    double childAspectRatio;
                    if (width < 500) {
                      crossAxisCount = isPortrait ? 1 : 2;
                      childAspectRatio = isPortrait ? 2.2 : 1.8;
                    } else {
                      crossAxisCount = isPortrait ? 2 : 3;
                      childAspectRatio = isPortrait ? 2.2 : 1.5;
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: childAspectRatio,
                      ),
                      itemCount: _products.length,
                      itemBuilder: (context, index) {
                        final product = _products[index];
                        return GestureDetector(
                          onTap: () {
                            widget.onNavigate?.call(1);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProductDetailScreen(product: product),
                              ),
                            ).then((_) {
                              widget.onNavigate?.call(0);
                            });
                          },
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Image.network(
                                        product.image,
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                        errorBuilder: (_, _, _) =>
                                            Container(
                                          color: Colors.grey[300],
                                          child: const Icon(
                                            Icons.image_not_supported,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              product.name,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 2,
                                              overflow:
                                                  TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              children: [
                                                  Text(
                                                    '\$${product.price.toStringAsFixed(0)}',
                                                    style: const TextStyle(
                                                    fontSize: 11,
                                                    decoration:
                                                        TextDecoration
                                                            .lineThrough,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                const SizedBox(width: 6),
                                                  Text(
                                                    '\$${product.discountedPrice.toStringAsFixed(0)}',
                                                    style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .error,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (product.discountPercent > 0)
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      padding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        '-${product.discountPercent.toStringAsFixed(0)}%',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
