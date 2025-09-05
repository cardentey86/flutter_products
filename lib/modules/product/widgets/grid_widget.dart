import 'package:flutter/material.dart';
import 'package:productos/modules/product/models/product_model.dart';

class ProductGridWidget extends StatelessWidget {
  final List<ProductModel> products;

  const ProductGridWidget({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Icon(Icons.list, size: 24,),
              SizedBox(width: 8,),
              Text('Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ],
          ), 
        ),
        Expanded(
          child: ListView.builder(
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
          ),
        ),
      ],
    );
  }
}
