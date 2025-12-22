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
    //_database = await initDB();

    String dbPath = 'E:\\project1';
    String path = join(dbPath, 'studentManager11.db');
    return await openDatabase(path, version: 1);
  }
}