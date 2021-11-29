import 'package:hestia/Model/budget.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BudgetDatabase {
  static final BudgetDatabase instance = BudgetDatabase._init();

  static Database? _databaseBudget;

  BudgetDatabase._init();

  Future<Database> get databaseBudget async {
    if (_databaseBudget != null) return _databaseBudget!;

    _databaseBudget = await _initDB('budget.db');
    return _databaseBudget!;
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

    await db.execute('''CREATE TABLE $tableBudget(
      ${BudgetFields.budgetID} $idType,
      ${BudgetFields.budgetName} $textType,
      ${BudgetFields.budgetQuantity} $intType,
      ${BudgetFields.budgetDescription} $textType
    )''');
  }

  Future<Budget> create(Budget budget) async {
    final db = await instance.databaseBudget;
    final id = await db.insert(tableBudget, budget.toJson());

    return budget.copy(budgetID: id);
  }

  Future<Budget> readBudget(int id) async {
    final db = await instance.databaseBudget;

    final maps = await db.query(tableBudget,
        columns: BudgetFields.values,
        where: '${BudgetFields.budgetID} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Budget.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Budget>> readAllBudget() async {
    final db = await instance.databaseBudget;
    final orderBy = '${BudgetFields.budgetName} ASC';
    final result = await db.query(tableBudget, orderBy: orderBy);

    return result.map((json) => Budget.fromJson(json)).toList();
  }

  Future<int> update(Budget budget) async {
    final db = await instance.databaseBudget;

    return db.update(
      tableBudget,
      budget.toJson(),
      where: '${BudgetFields.budgetID} = ?',
      whereArgs: [budget.budgetID],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.databaseBudget;

    return await db.delete(tableBudget,
        where: '${BudgetFields.budgetID} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.databaseBudget;
    db.close();
  }
}
