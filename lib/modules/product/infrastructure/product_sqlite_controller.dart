import 'package:productos/modules/product/models/product_model.dart';

import '../../data/database.dart';

class ProductSqliteController {
  Future<void> insertProduct(ProductModel product) async {
    final db = await AppDatabase.initDB();
    await db.insert("products", {"name": product.name, "avatar": product.avatar, "approved": product.approved! ? 1 : 0 });
  }

  Future<List<ProductModel>> getProducts() async {
    final db = await AppDatabase.initDB();
    final result = await db.query("products");
    return result.map((row) => ProductModel.fromObject(row)).toList();
  }

  Future<void> updateProduct(int id, ProductModel product) async {
    final db = await AppDatabase.initDB();
    await db.update(
      "products",
      {"name": product.name, "avatar": product.avatar, "approved" : product.approved! ? 1 : 0},
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteProduct(int id) async {
    final db = await AppDatabase.initDB();
    await db.delete("products", where: "id = ?", whereArgs: [id]);
  }
}
