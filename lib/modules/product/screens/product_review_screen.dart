import 'package:flutter/material.dart';
import 'package:productos/modules/product/infrastructure/product_sqlite_controller.dart';

import '../models/product_model.dart';
import '../widgets/grid_widget.dart';

class ProductReviewScreen extends StatefulWidget {
  const ProductReviewScreen({super.key});

  @override
  State<ProductReviewScreen> createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<List<ProductModel>>(
            future: ProductSqliteController().getProducts(),
            builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
              if (snapshot.hasData) {
                return ProductGridWidget(products: snapshot.data!, localProducts: snapshot.data, showCheckBox: false, scaffoldContext: context, showBtnToEmptyLocalProducts: true, itemsPerPage: 7,);
              } else {
                return const Center(child: Text('No products found'));
              }
            },
          ),
        )
      ],
    );
  }
}
