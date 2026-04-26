import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _db;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB('medivault.db');
    return _db!;
  }

  Future<Database> _initDB(String file) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, file);

    return openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE profile (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        age TEXT,
        bloodGroup TEXT,
        allergies TEXT,
        disease TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE documents (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        path TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE reminders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT
      )
    ''');
  }

  // ---------------- PROFILE ----------------

  Future<int> insertProfile(Map<String, dynamic> data) async {
    final db = await database;

    await db.delete('profile'); // keep ONLY 1 profile (VERY IMPORTANT)

    return db.insert('profile', {
      'name': data['name'],
      'age': data['age'],
      'bloodGroup': data['bloodGroup'],
      'allergies': data['allergies'],
      'disease': data['disease'],
    });
  }

  Future<Map<String, dynamic>?> getProfile() async {
    final db = await database;
    final res = await db.query('profile');

    if (res.isEmpty) return null;
    return res.first;
  }

  // ---------------- DOCUMENTS ----------------

  Future<int> insertDocument(String name, String path) async {
    final db = await database;

    return db.insert('documents', {
      'name': name,
      'path': path,
    });
  }

  Future<List<Map<String, dynamic>>> getDocuments() async {
    final db = await database;
    return db.query('documents');
  }

  Future<void> deleteDocument(int id) async {
    final db = await database;
    await db.delete('documents', where: 'id = ?', whereArgs: [id]);
  }

  // ---------------- REMINDERS ----------------

  Future<int> insertReminder(String title) async {
    final db = await database;

    return db.insert('reminders', {
      'title': title,
    });
  }

  Future<List<Map<String, dynamic>>> getReminders() async {
    final db = await database;
    return db.query('reminders');
  }

  Future<void> deleteReminder(int id) async {
    final db = await database;
    await db.delete('reminders', where: 'id = ?', whereArgs: [id]);
  }
}