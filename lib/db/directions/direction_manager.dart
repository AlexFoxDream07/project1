import 'package:project1/db/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:project1/db/directions/directions.dart';

class DirectionManager {
  Future<List<Directions>> readDir() async {
    Database? db = await DBHelp.instance.initDB();
    List<Map<String, dynamic>> directions = await db.query('directions', orderBy: 'id');
    List<Directions> directionsList = directions.isNotEmpty
    ? directions.map((direction) => Directions.fromMap(direction)).toList()
    : [];
    return directionsList;
  }
  Future<int> insertDir(Directions direction) async {
    Database db = await DBHelp.instance.db;
    return db.insert('directions', direction.toMap());
  }
  Future<int> updateDir(Directions direction) async {
    Database db = await DBHelp.instance.db;
    return db.update('directions', direction.toMap(), where: 'id = ?', whereArgs: [direction.id]);
  }
  Future<int> deleteGrDir(Directions direction) async {
    Database db = await DBHelp.instance.db;
    return db.delete('directions', where: 'id = ?', whereArgs: [direction.id]);
  }
}