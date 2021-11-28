import 'package:hestia/Model/inventory.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class InventoryDatabase {
  static final InventoryDatabase instance = InventoryDatabase._init();

  static Database? _databaseInv;

  InventoryDatabase._init();

  Future<Database> get databaseInv async {
    if (_databaseInv != null) return _databaseInv!;

    _databaseInv = await _initDB('inventory.db');
    return _databaseInv!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final intType = 'INTEGER NOT NULL';

    await db.execute('''CREATE TABLE $tableInventory(
        ${InventoryFields.inventoryID} $idType,
        ${InventoryFields.inventoryTitle} $textType,
        ${InventoryFields.inventoryCategory} $textType,
        ${InventoryFields.inventoryQuantity} $intType,
        ${InventoryFields.inventoryMeasure} $textType
    )''');
  }

  Future<Inventory> create(Inventory inventory) async {
    final db = await instance.databaseInv;
    final id = await db.insert(tableInventory, inventory.toJson());

    return inventory.copy(inventoryID: id);
  }

  Future<Inventory> readInventory(int id) async {
    final db = await instance.databaseInv;

    final maps = await db.query(tableInventory,
        columns: InventoryFields.values,
        where: '${InventoryFields.inventoryID} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Inventory.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Inventory>> readAllInventory() async {
    final db = await instance.databaseInv;
    final orderBy = '${InventoryFields.inventoryCategory} ASC';
    final result = await db.query(tableInventory, orderBy: orderBy);

    return result.map((json) => Inventory.fromJson(json)).toList();
  }

  Future<int> update(Inventory inventory) async {
    final db = await instance.databaseInv;

    return db.update(
      tableInventory,
      inventory.toJson(),
      where: '${InventoryFields.inventoryID} = ?',
      whereArgs: [inventory.inventoryID],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.databaseInv;

    return await db.delete(
      tableInventory,
      where: '${InventoryFields.inventoryID} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.databaseInv;
    db.close();
  }
}
