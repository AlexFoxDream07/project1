import 'package:project1/db/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:project1/db/groups/groups.dart';

class GroupManager {
  Future<List<Groups>> readGroup() async {
    Database? db = await DBHelp.instance.initDB();
    List<Map<String, dynamic>> group = await db.query('groups', orderBy: 'id');
    List<Groups> groupList = group.isNotEmpty
    ? group.map((group) => Groups.fromMap(group)).toList()
    : [];
    return groupList;
  }
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

  Future<bool> isIDexist(int id) async {
    Database db = await DBHelp.instance.db;
    final List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT id
      FROM directions 
    ''');
    List<int> asd = results.map((map) => map['id'] as int).toList();
    for (int i = 0; i < results.length; i++){
      if (id == asd[i]){
        return true;
      }
    }
     return false;
  }
}