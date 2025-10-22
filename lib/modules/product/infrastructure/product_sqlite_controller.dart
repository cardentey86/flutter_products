import 'package:productos/modules/product/models/product_model.dart';

import '../../../data/database.dart';
import 'package:sqflite/sqflite.dart';

import '../../../helpers/sqlite_adapter.dart';

class ProductSqliteController {

  final _adapter = SqliteAdapter<ProductModel>(
    tableName: 'products',
    model: ProductModel.empty(),
  );

  Future<bool> insertProduct(ProductModel product) => _adapter.insert(product);
  Future<List<ProductModel>> getProducts() => _adapter.getAll();
  Future<ProductModel?> getProductById(String id) => _adapter.getById(id);
  Future<int> updateProduct(String id, ProductModel product) => _adapter.update(id, product);
  Future<bool> deleteProduct(String id) => _adapter.delete(id);
  Future<bool> deleteAllProducts() => _adapter.deleteAll();

  // Future<bool> insertProduct(ProductModel product) async {
  //   final db = await AppDatabase.initDB();
  //   final result = await db.insert(
  //     "products",
  //     product.toObject(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  //
  //   return result > 0;
  // }
  //
  // Future<List<ProductModel>> getProducts() async {
  //   final db = await AppDatabase.initDB();
  //   final result = await db.query("products");
  //   return result.map((row) => ProductModel.fromObject(row)).toList();
  // }
  //
  // Future<int> updateProduct(int id, ProductModel product) async {
  //   final db = await AppDatabase.initDB();
  //   return await db.update(
  //     "products",
  //     product.toObject(),
  //     where: "id = ?",
  //     whereArgs: [product.id],
  //   );
  // }
  // Future<ProductModel?> getProductById(int id) async {
  //   final db = await AppDatabase.initDB();
  //   final result = await db.query(
  //     "products",
  //     where: "id = ?",
  //     whereArgs: [id],
  //     limit: 1,
  //   );
  //
  //   if (result.isNotEmpty) {
  //     return ProductModel.fromObject(result.first);
  //   }
  //   return null;
  // }
  //
  //
  // Future<bool> deleteProduct(String id) async {
  //   final db = await AppDatabase.initDB();
  //   return await db.delete("products", where: "id = ?", whereArgs: [id]) != "";
  // }
  //
  // Future<bool> deleteAllProducts() async {
  //   final db = await AppDatabase.initDB();
  //   return await db.delete("products") > 0;
  // }
}
