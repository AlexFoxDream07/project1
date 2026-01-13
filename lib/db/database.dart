import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelp{
  static final DBHelp instance = DBHelp._instance();
  static Database? _database;

  DBHelp._instance();

  Future<Database> get db async{
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<void> createTables(Database db, int version) async {
  try {
    await db.execute('PRAGMA foreign_keys = ON');

    await db.execute('''
      CREATE TABLE directions (
        id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
        name TEXT NOT NULL,
        code TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE groups (
        id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
        directionId INTEGER NOT NULL,
        name TEXT NOT NULL,
        year TEXT NOT NULL,
        FOREIGN KEY (directionId) REFERENCES Direction(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE students (
        id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
        fullName TEXT NOT NULL,
        groupId INTEGER NOT NULL,
        averageGrade REAL NOT NULL,
        FOREIGN KEY (groupId) REFERENCES Groups(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE grades (
        id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
        studentId INTEGER NOT NULL,
        grade INTEGER NOT NULL,
        FOREIGN KEY (studentId) REFERENCES Students(id)
      )
    '''); 
  } catch (e) {
    print('Ошибка при создании таблиц: $e');
    rethrow;
  }
}

  Future<Database> initDB() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, "studentManager11.db");
      _database = await openDatabase(path, version: 3, 
        onCreate: (Database db, int version) async {
          await db.execute('PRAGMA foreign_keys = ON');
          await createTables(db, version);
      }
    );
    return _database!;
    } catch (e) {
      print('Ошибка открытия или создания базы данных: $e');
      rethrow;
    }
  }
}