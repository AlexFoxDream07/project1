import 'package:project1/db/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:project1/db/tables.dart';

class GradeManager {
  Future<int> insertGrade(Grades grade) async {
    Database db = await DBHelp.instance.db;
    return db.insert('grades', grade.toMap());
  }
  Future<int> updateGrade(Grades grade) async {
    Database db = await DBHelp.instance.db;
    return db.update('grades', grade.toMap(), where: 'id = ?', whereArgs: [grade.id]);
  }
  Future<int> deleteGrade(Grades grade) async {
    Database db = await DBHelp.instance.db;
    return db.delete('grades', where: 'id = ?', whereArgs: [grade.id]);
  }
}