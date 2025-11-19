import 'package:flutter_evs/Contacto/contacto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  factory DbHelper() => _instance;
  DbHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'contactos.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE contactos ( id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT NOT NULL, telefono TEXT NOT NULL, apellido TEXT NOT NULL, domicilio TEXT NOT NULL, genero TEXT NOT NULL)',
        );
      },
    );
  }

  Future<int> insertContacto(Contacto contacto) async {
    final db = await database;
    int id = await db.insert(
      'contactos',
      contacto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<Contacto>> getContactos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('contactos');
    return List.generate(maps.length, (i) {
      return Contacto.fromMap(maps[i]);
    });
  }

  Future<void> deleteContacto(int id) async {
    final db = await database;
    await db.delete('contactos', where: 'id = ?', whereArgs: [id]);
  }
}
