import 'package:flutter/material.dart';
import 'package:productos/modules/product/infrastructure/product_controller.dart';
import 'package:productos/modules/product/models/product_model.dart';

import '../widgets/grid_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  Future<List<ProductModel>> fetchProducts() async {
    final List<ProductModel> data = await ProductController.getProducts();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(future: fetchProducts(),
        builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ProductGridWidget(products: snapshot.data!);
          } else {
            return const Center(child: Text('No products found'));
          }
        }
    );
  }
}
