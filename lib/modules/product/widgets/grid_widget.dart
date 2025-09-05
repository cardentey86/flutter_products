import 'package:flutter/material.dart';
import 'package:productos/modules/product/models/product_model.dart';

class ProductGridWidget extends StatelessWidget {
  final List<ProductModel> products;

  const ProductGridWidget({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          key: Key(product.id),
            title: Text(product.name),
            leading: CircleAvatar(backgroundImage: NetworkImage(product.avatar)
          ),
        );
      },
    );
  }
}
