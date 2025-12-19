import 'package:project1/db/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:project1/db/tables.dart';


class StudentManager {
  // List<Students> readStud() {
  //   Database? db;
  //   var stud = db!.query('students', orderBy: 'id');
  //   List<Students> studList = stud.isNotEmpty
  //   ? stud.map((stud) => Students.fromMap(stud)).toList()
  //   : [];

  //   return studList;
  // }
  Future<int> insertStud(Students student) async {
    Database db = await DBHelp.instance.db;
    return await db.insert('students', student.toMap());
  }
  Future<int> updateStud(Students student) async {
    Database db = await DBHelp.instance.db;
    return db.update('students', student.toMap(), where: 'id = ?', whereArgs: [student.id]);
  }
  Future<int> deleteStud(Students student) async{
    Database db = await DBHelp.instance.db;
    return db.delete('students', where: 'id = ?', whereArgs: [student.id]);
  }
}