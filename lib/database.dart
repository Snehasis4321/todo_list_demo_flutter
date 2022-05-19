import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:text_validation_advanced/model.dart';

class TodoDatabase {
  static final TodoDatabase instance = TodoDatabase._init();

  static Database? _database;

  TodoDatabase._init();

// create database if it does not exits

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('todsDB');
    return _database!;
  }

  // create initDB function

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // create table

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE todos(id INTEGER PRIMARY KEY, task TEXT)''');
  }

  // display all items in the database

  Future<List<Todo>> getTodos() async {
    final db = await instance.database;

    var todoList =
        await db.query('todos', orderBy: 'id'); //select * from todos;

    List<Todo> todos =
        todoList.isNotEmpty ? todoList.map((e) => Todo.fromDB(e)).toList() : [];

    return todos;
  }

// create a todo
  Future<int> addTodo(Todo todo) async {
    final db = await instance.database;
    return await db.insert('todos', todo.toDB());
  }

  // delete the todo
  Future<int> removeTodo(int id) async {
    final db = await instance.database;
    return await db.delete('todos', where: 'id=?', whereArgs: [id]);
  }

//update the todo
  Future<int> updateTodo(Todo todo) async {
    final db = await instance.database;
    return await db
        .update('todos', todo.toDB(), where: 'id=?', whereArgs: [todo.id]);
  }
}
