import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:productos/modules/product/infrastructure/product_sqlite_controller.dart';
import 'package:productos/modules/product/models/product_model.dart';
import 'package:productos/modules/product/widgets/dialog/conformationDialog_widget.dart';
import 'package:productos/modules/product/widgets/dialog/dialog_type.dart';

class GridWidget extends StatefulWidget {
  final List<ProductModel> products;
  final List<ProductModel>? localProducts;
  final bool showCheckBox;
  final bool showBtnToEmptyLocalProducts;
  final BuildContext scaffoldContext;
  final int? itemsPerPage;
  final String title;
  final bool? isLocale;

  const GridWidget({
    super.key,
    required this.products,
    this.localProducts,
    this.itemsPerPage,
    this.isLocale = false,
    required this.showCheckBox,
    required this.scaffoldContext,
    required this.showBtnToEmptyLocalProducts,
    required this.title,

  });

  @override
  State<GridWidget> createState() => _ProductGridWidgetState();
}

class _ProductGridWidgetState extends State<GridWidget> {
  late List<ProductModel> localProducts;
  int currentPage = 0;
  int itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    localProducts = widget.localProducts ?? [];
    itemsPerPage = widget.itemsPerPage ?? 10;
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = (widget.products.length / itemsPerPage).ceil();

    final startIndex = currentPage * itemsPerPage;
    final endIndex =
    (startIndex + itemsPerPage) > widget.products.length
        ? widget.products.length
        : startIndex + itemsPerPage;

    final currentItems = widget.products.sublist(startIndex, endIndex);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children:[
              Row(
                children: [
                  const Icon(Icons.list, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  if (widget.showBtnToEmptyLocalProducts &&
                      localProducts.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.delete, size: 24, color: Colors.red),
                      onPressed: () async {
                        await ConfirmationDialog.show(
                          context,
                          title: 'Delete all products?',
                          content: 'This action cannot be undone.',
                          type: DialogType.Eliminacion,
                          onConfirm: () async {
                            await emptyLocalProducts();
                            setState(() {
                              localProducts.clear();
                              for (var p in widget.products) {
                                p.approved = false;
                              }
                            });
                            showSnackBar(context, 'All products deleted');
                          },
                        );
                      },
                    ),
                ],
              ),
              Row(children: [
                Spacer(),
                Text('Showing $itemsPerPage items per page')
              ],)
            ] 
          ),
        ),

        // Paginated listview
        Expanded(
          child: ListView.builder(
            itemCount: currentItems.length,
            itemBuilder: (context, index) {
              final product = currentItems[index];
              final isChecked =
              localProducts.any((p) => p.id == product.id);

              final listTile = ListTile(
                key: Key(product.id),
                title: Text(product.name),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(product.avatar),
                ),
                trailing: widget.showCheckBox
                    ? Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) async {
                    // Solo permitir marcar si no está en local
                    if (!isChecked && value == true) {
                      await aprove(
                          widget.scaffoldContext, product, value);
                      setState(() {
                        localProducts.add(product);
                      });
                    }
                  },
                )
                    : null,
              );
              if(widget.isLocale == false){
                return listTile;
              } else {
                return Slidable(
                  key: ValueKey('slide_${product.id}'),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.25,
                    children: [
                      SlidableAction(
                        onPressed: (_) async {

                          showSnackBar(context, 'Edit ${product.name}');
                        },
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.green,
                        icon: Icons.edit,
                        label: 'Edit',
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(), // puedes usar ScrollMotion para otro efecto
                    extentRatio: 0.25,
                    children: [
                      SlidableAction(
                        onPressed: (_) async {
                          await ConfirmationDialog.show(
                            context,
                            title: 'Delete product?',
                            content:
                            'Are you sure you want to delete "${product.name}"?',
                            type: DialogType.Eliminacion,
                            onConfirm: () async {
                              await deleteProduct(product);
                              setState(() {
                                localProducts.removeWhere((p) => p.id == product.id);
                              });
                              showSnackBar(context, 'Product deleted');
                            },
                          );
                        },
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.red,
                        icon: Icons.delete,
                        label: 'Delete',
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ],
                  ),
                  child: listTile,
                );

                // return Dismissible(
                //   key: Key('dismiss_${product.id}'),
                //   direction: DismissDirection.endToStart,
                //   child: listTile,
                //   background: Container(
                //     color: Colors.redAccent,
                //     alignment: Alignment.centerRight,
                //     padding: const EdgeInsets.symmetric(horizontal: 20),
                //     child: const Icon(Icons.delete, color: Colors.white, size: 28),
                //   ),
                //   confirmDismiss: (direction) async {
                //     await ConfirmationDialog.show(
                //       context,
                //       title: 'Delete product?',
                //       content: 'Are you sure you want to delete "${product.name}"?',
                //       type: DialogType.Eliminacion,
                //         onConfirm: () async {
                //           await deleteProduct(product);
                //           setState(() {
                //           localProducts.removeWhere((p) => p.id == product.id);
                //         });
                //       showSnackBar(context, 'Product deleted');
                //     },
                //   );
                //   }
                // );
              }

            },

          ),
        ),

        // Pagination controls
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: currentPage > 0
                  ? () {
                setState(() {
                  currentPage--;
                });
              }
                  : null,
            ),
            Text('${currentPage + 1} / $totalPages'),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: currentPage < totalPages - 1
                  ? () {
                setState(() {
                  currentPage++;
                });
              }
                  : null,
            ),
          ],
        ),
      ],
    );
  }

  Future<void> aprove(
      BuildContext context, ProductModel product, bool? value) async {
    product.approved = value;
    final result = await ProductSqliteController().insertProduct(product);
    if (result) {
      showSnackBar(context, 'Product added to local database');
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  Future<void> deleteProduct(ProductModel product) async {
    await ProductSqliteController().deleteProduct(product.id);
  }

  Future<void> emptyLocalProducts() async {
    await ProductSqliteController().deleteAllProducts();
  }
}
