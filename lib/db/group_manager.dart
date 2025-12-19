import 'package:project1/db/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:project1/db/tables.dart';

class GroupManager {
  Future<int> insertGroup(Groups group) async {
    Database db = await DBHelp.instance.db;
    return db.insert('groups', group.toMap());
  }
  Future<int> updateGroup(Groups group) async {
    Database db = await DBHelp.instance.db;
    return db.update('groups', group.toMap(), where: 'id = ?', whereArgs: [group.id]);
  }
  Future<int> deleteGrGroup(Groups group) async {
    Database db = await DBHelp.instance.db;
    return db.delete('groups', where: 'id = ?', whereArgs: [group.id]);
  }
}