import 'package:project1/db/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:project1/db/directions/directions.dart';

class DirectionManager {
  Future<List<Direction>> readDir() async {
    Database? db = await DBHelp.instance.initDB();
    List<Map<String, dynamic>> directions = await db.query('directions', orderBy: 'id');
    List<Direction> directionsList = directions.isNotEmpty
    ? directions.map((direction) => Direction.fromMap(direction)).toList()
    : [];
    return directionsList;
  }
  Future<int> insertDir(Direction direction) async {
    Database db = await DBHelp.instance.db;
    return db.insert('directions', direction.toMap());
  }
  Future<int> updateDir(Direction direction) async {
    Database db = await DBHelp.instance.db;
    return db.update('directions', direction.toMap(), where: 'id = ?', whereArgs: [direction.id]);
  }
  Future<int> deleteGrDir(Direction direction) async {
    Database db = await DBHelp.instance.db;
    return db.delete('directions', where: 'id = ?', whereArgs: [direction.id]);
  }
}