import 'package:sqflite/sqflite.dart';
import '../../data/database.dart';
import 'base_model_sqlite.dart';

class SqliteAdapter<T extends BaseModelSqlite<T>> {
  final String tableName;
  final T model;

  SqliteAdapter({
    required this.tableName,
    required this.model,
  });

  // 🔹 Insertar un registro
  Future<bool> insert(T item) async {
    final db = await AppDatabase.initDB();
    final result = await db.insert(
      tableName,
      item.toObject(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result > 0;
  }

  // 🔹 Obtener todos los registros
  Future<List<T>> getAll() async {
    final db = await AppDatabase.initDB();
    final result = await db.query(tableName);
    return result.map((row) => model.fromObject(row)).toList();
  }

  // 🔹 Obtener un registro por ID
  Future<T?> getById(dynamic id) async {
    final db = await AppDatabase.initDB();
    final result = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (result.isNotEmpty) {
      return model.fromObject(result.first);
    }
    return null;
  }

  // 🔹 Actualizar un registro
  Future<int> update(dynamic id, T item) async {
    final db = await AppDatabase.initDB();
    return await db.update(
      tableName,
      item.toObject(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 🔹 Eliminar un registro
  Future<bool> delete(dynamic id) async {
    final db = await AppDatabase.initDB();
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]) > 0;
  }

  // 🔹 Eliminar todos los registros
  Future<bool> deleteAll() async {
    final db = await AppDatabase.initDB();
    return await db.delete(tableName) > 0;
  }
}
