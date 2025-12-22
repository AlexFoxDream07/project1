import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelp{
  static final DBHelp instance = DBHelp._instance();
  static Database? _database;

  DBHelp._instance();

  Future<Database> get db async{
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String dbPath = 'E:\\project1';
    String path = join(dbPath, 'studentManager11.db');
    try {
    _database = await openDatabase(path);
    } catch (e) {
      print('Ошибка открытия базы данных: $e');
    } 
    return await openDatabase(path, version: 1);
  }
}