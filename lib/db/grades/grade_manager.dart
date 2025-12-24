import 'package:project1/db/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:project1/db/grades/grades.dart';

class GradeManager {
  Future<List<Grades>> readGrade() async {
    Database? db = await DBHelp.instance.initDB();
    List<Map<String, dynamic>> grade = await db.query('grades', orderBy: 'id');
    List<Grades> gradeList = grade.isNotEmpty
    ? grade.map((grade) => Grades.fromMap(grade)).toList()
    : [];

    return gradeList;
  }
  Future<int> insertGrade(Grades grade) async {
    Database db = await DBHelp.instance.db;
    await _updateAverageGrade(grade.studentID, db);
    return db.insert('grades', grade.toMap());
  }
  Future<int> updateGrade(Grades grade) async {
    Database db = await DBHelp.instance.db;
    await _updateAverageGrade(grade.studentID, db);
    return db.update('grades', grade.toMap(), where: 'id = ?', whereArgs: [grade.id]);
  }
  Future<int> deleteGrade(Grades grade) async {
    Database db = await DBHelp.instance.db;
    await _updateAverageGrade(grade.studentID, db);
    return db.delete('grades', where: 'id = ?', whereArgs: [grade.id]);
  }

  Future<void> _updateAverageGrade(int studentId, Database db) async {
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT AVG(grade) AS averageGrade
      FROM grades
      WHERE studentId = ?
    ''', [studentId]);

    double averageGrade = (result.isNotEmpty && result[0]['averageGrade'] != null)
        ? result[0]['averageGrade'] as double
        : 0.0;

    await db.rawUpdate('''
      UPDATE students
      SET averageGrade = ?
      WHERE id = ?
    ''', [averageGrade, studentId]);
  }

  Future<void> updateStudentAverageGrade(int studentId) async {
    Database db = await DBHelp.instance.db;
    await _updateAverageGrade(studentId, db);
  }
}