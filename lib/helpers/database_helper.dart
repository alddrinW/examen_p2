import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._privateConstructor();
  static DatabaseHelper get instance {
    _instance ??= DatabaseHelper._privateConstructor();
    return _instance!;
  }

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'galeria.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE galeria (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT,
        imageUrl TEXT,
        autor TEXT
      )
    ''');

    String autor = 'AV-D';
    List<Map<String, dynamic>> registros = List.generate(
      15,
      (index) => {
        'titulo': 'Imagen ${index + 1}',
        'imageUrl': 'https://source.unsplash.com/random/200x200?sig=$index',
        'autor': autor,
      },
    );

    for (var registro in registros) {
      await db.insert('galeria', registro);
    }
  }

  // Método para leer los registros filtrados por autor
  Future<List<Map<String, dynamic>>> getRegistros(String autor) async {
    Database db = await database;
    return await db.query('galeria', where: 'autor = ?', whereArgs: [autor]);
  }
}
