import 'package:ewhatsapp/sqflite_db/item_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ItemDatabase {
  static final ItemDatabase instance = ItemDatabase._init();

  static Database? _database;

  ItemDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('item.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const doubleType = 'REAL NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE $itemTable (
    ${ItemFields.id} $idType,
    ${ItemFields.name} $textType,
    ${ItemFields.rate} $doubleType,
    ${ItemFields.image} $textType,
    ${ItemFields.piece} $textType,
    ${ItemFields.totalRate} $doubleType,
    ${ItemFields.cartCount} $integerType,
    ${ItemFields.isFavourite} $boolType
    )
    ''');
  }

  Future<Item> create(Item item) async {
    final db = await instance.database;

    final id = await db.insert(itemTable, item.toJson());
    return item.copy(id: id);
  }

  Future<Item?> readData(int id) async {
    final db = await instance.database;

    final maps = await db.query(itemTable,
        columns: ItemFields.values,
        where: '${ItemFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Item.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Item>> readAllItemhData() async {
    final db = await instance.database;

    final result = await db.query(itemTable);

    return result.map((json) => Item.fromJson(json)).toList();
  }

  Future<int> update(Item item) async {
    final db = await instance.database;

    return db.update(
      itemTable,
      item.toJson(),
      where: '${ItemFields.id} = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      itemTable,
      where: '${ItemFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteTable() async {
    final db = await instance.database;

    return await db.delete(itemTable);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
