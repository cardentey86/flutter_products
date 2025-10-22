import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products (
            id TEXT NOT NULL PRIMARY KEY,
            name TEXT NOT NULL,
            avatar TEXT NOT NULL,
            approved INTEGER NOT NULL DEFAULT 0
          )
        ''');
      },
    );
  }
}
