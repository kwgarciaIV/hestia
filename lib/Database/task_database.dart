import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hestia/Model/task.dart';

class TaskDatabase {
  static final TaskDatabase instance = TaskDatabase._init();

  static Database? _database;

  TaskDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''CREATE TABLE $tableTask(
        ${TaskFields.taskID} $idType,
        ${TaskFields.taskTitle} $textType, 
        ${TaskFields.taskDescription} $textType, 
        ${TaskFields.taskCategory} $textType
    )''');
  }

  Future<Task> create(Task task) async {
    final db = await instance.database;
    final id = await db.insert(tableTask, task.toJson());

    return task.copy(taskID: id);
  }

  Future<Task> readTask(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableTask,
        columns: TaskFields.values,
        where: '${TaskFields.taskID} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Task.fromJson((maps.first));
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Task>> readAllTasks() async {
    final db = await instance.database;

    final orderBy = '${TaskFields.taskCategory} ASC';
    final result = await db.query(tableTask, orderBy: orderBy);

    return result.map((json) => Task.fromJson(json)).toList();
  }

  Future<int> update(Task task) async {
    final db = await instance.database;

    return db.update(
      tableTask,
      task.toJson(),
      where: '${TaskFields.taskID} = ?',
      whereArgs: [task.taskID],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db
        .rawDelete('DELETE FROM $tableTask WHERE ${TaskFields.taskID} = $id');
  }

  Future<int> deleteAll() async {
    final db = await instance.database;

    return await db.rawDelete('DELETE FROM $tableTask');
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
