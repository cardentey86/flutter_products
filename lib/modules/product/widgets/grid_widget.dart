import 'package:flutter/material.dart';
import 'package:productos/modules/product/infrastructure/product_sqlite_controller.dart';
import 'package:productos/modules/product/models/product_model.dart';
import 'package:productos/modules/product/widgets/dialog/conformationDialog_widget.dart';
import 'package:productos/modules/product/widgets/dialog/dialog_type.dart';

class ProductGridWidget extends StatefulWidget {
  final List<ProductModel> products;
  final List<ProductModel>? localProducts;
  final bool showCheckBox;
  final bool showBtnToEmptyLocalProducts;
  final BuildContext scaffoldContext;

  const ProductGridWidget({
    super.key,
    required this.products,
    this.localProducts,
    required this.showCheckBox,
    required this.scaffoldContext,
    required this.showBtnToEmptyLocalProducts,
  });

  @override
  State<ProductGridWidget> createState() => _ProductGridWidgetState();
}

class _ProductGridWidgetState extends State<ProductGridWidget> {
  late List<ProductModel> localProducts;

  @override
  void initState() {
    super.initState();
    localProducts = widget.localProducts ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.list, size: 24,),
              SizedBox(width: 8,),
              Text('Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Spacer(),
              if (widget.showBtnToEmptyLocalProducts &&
                  widget.localProducts != null &&
                  widget.localProducts!.isNotEmpty)
                IconButton(
                  onPressed: () async {
                    await ConfirmationDialog.show(
                      context,
                      title: 'Delete all products?',
                      content: 'This action cannot be undone.',
                      onConfirm: () {
                        emptyLocalProducts();
                        showSnackBar(context, 'All products deleted');
                        clearLocalProducts();
                        },
                      type: DialogType.Eliminacion);
                    },
                  icon: const Icon(Icons.delete, size: 24, color: Colors.red),
                ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.products.length,
            itemBuilder: (context, index) {
              final product = widget.products[index];
              final isChecked = widget.localProducts!.any((p) => p.id == product.id);
              return ListTile(
                key: Key(product.id),
                title: Text(product.name),
                leading: CircleAvatar(backgroundImage: NetworkImage(product.avatar),),
                trailing: widget.showCheckBox  ? Checkbox(value: isChecked,
                    onChanged: (bool? value) async {
                      if (!isChecked && value == true) {
                        await aprove(widget.scaffoldContext, product, value);

                        setState(() {
                          localProducts.add(product);
                        });
                      }
                }):null,
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> aprove(BuildContext context, ProductModel product, bool? value) async {
    product.approved = value;
    final result = await ProductSqliteController().insertProduct(product);
    if (result)
    {
      showSnackBar(context, 'Product added to local database');
    }

  }

  bool checkLocalProduct(String id, List<ProductModel> localProducts)
  {
    if (localProducts.isNotEmpty)
      {
        return localProducts.any((prod)=> prod.id == id);
      }
    return false;
  }

  void clearLocalProducts(){
    setState(() {
      if (widget.localProducts != null) {
        widget.localProducts!.clear();
      }
      for (var p in widget.products) {
        p.approved = false;
      }
    });
  }

  void showSnackBar(BuildContext context, String message)
  {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> emptyLocalProducts() async {
    await ProductSqliteController().deleteAllProducts();
  }
}
