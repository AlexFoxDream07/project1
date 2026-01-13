import 'package:project1/db/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:project1/db/students/students.dart';

class StudentManager {
  Future<List<Students>> readStud() async {
    Database? db = await DBHelp.instance.initDB();
    List<Map<String, dynamic>> stud = await db.query('students', orderBy: 'id');
    List<Students> studList = stud.isNotEmpty
    ? stud.map((stud) => Students.fromMap(stud)).toList()
    : [];

    return studList;
  }
  Future<int> insertStud(Students student) async {
    Database db = await DBHelp.instance.db;
    return await db.insert('students', student.toMap());
  }
  Future<int> updateStud(Students student) async {
    Database db = await DBHelp.instance.db;
      final int rowsUpdated = await db.update(
      'students',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
  );
    return rowsUpdated;
  }
  Future<int> deleteStud(Students student) async{
    Database db = await DBHelp.instance.db;
    return db.delete('students', where: 'id = ?', whereArgs: [student.id]);
  }

  Future<bool> isIDexist(int id) async {
    Database db = await DBHelp.instance.db;
    final List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT id
      FROM groups 
    ''');
    List<int> asd = results.map((map) => map['id'] as int).toList();
    for (int i = 0; i < results.length; i++){
      if (id == asd[i]){
        return true;
      }
    }
     return false;
  }
  
  Future<List<Students>> getStudentsWithLowAverageGrade() async {
    Database? db = await DBHelp.instance.initDB();
    final List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT id, fullName, groupId, averageGrade
      FROM students
      WHERE averageGrade <= 3
    ''');

    return results.map((map) => Students(
      id: map['id'] as int,
      fullName: map['fullName'] as String,
      groupId: map['groupId'] as int,
      averageGrade: map['averageGrade'] as double,
      )
    ).toList();
  }
}