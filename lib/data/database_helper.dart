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
      version: 3, // ✅ bumped version
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // ---------------- PROFILE ----------------
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

    // ---------------- DOCUMENTS ----------------
    await db.execute('''
      CREATE TABLE documents (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        path TEXT
      )
    ''');

    // ---------------- REMINDERS (WITH TIME) ----------------
    await db.execute('''
      CREATE TABLE reminders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        time TEXT
      )
    ''');

    // ---------------- USERS ----------------
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE,
        password TEXT
      )
    ''');
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    // ✅ Add users table
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          email TEXT UNIQUE,
          password TEXT
        )
      ''');
    }

    // ✅ Add time column to reminders (IMPORTANT FIX)
    if (oldVersion < 3) {
      await db.execute('ALTER TABLE reminders ADD COLUMN time TEXT');
    }
  }

  // ---------------- PROFILE ----------------

  Future<int> insertProfile(Map<String, dynamic> data) async {
    final db = await database;

    await db.delete('profile'); // keep only 1

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

  Future<int> insertReminder(String title, String time) async {
    final db = await database;

    return db.insert('reminders', {
      'title': title,
      'time': time,
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

  // ---------------- USERS ----------------

  Future<int> registerUser(String email, String password) async {
    final db = await database;

    return db.insert('users', {
      'email': email,
      'password': password,
    });
  }

  Future<Map<String, dynamic>?> loginUser(
      String email, String password) async {
    final db = await database;

    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) return result.first;
    return null;
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;

    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) return result.first;
    return null;
  }
}