import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheProduct(ProductModel product);
  Future<List<ProductModel>> getWishlist();
  Future<void> removeProductFromWishlist(int id);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  static final ProductLocalDataSourceImpl _instance =
      ProductLocalDataSourceImpl._internal();
  factory ProductLocalDataSourceImpl() => _instance;
  ProductLocalDataSourceImpl._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'wishlist.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE wishlist(id INTEGER PRIMARY KEY, title TEXT, description TEXT, price REAL, image TEXT, categoryId INTEGER)',
        );
      },
    );
  }

  @override
  Future<void> cacheProduct(ProductModel product) async {
    final db = await database;
    await db.insert(
      'wishlist',
      product.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<ProductModel>> getWishlist() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('wishlist');
    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return ProductModel.fromJson(maps[i]);
      });
    } else {
      return [];
    }
  }

  @override
  Future<void> removeProductFromWishlist(int id) async {
    final db = await database;
    await db.delete(
      'wishlist',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
