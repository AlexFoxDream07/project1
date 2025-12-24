import 'package:flutter/material.dart';
import 'package:project1/db/grades/grades.dart';
import 'package:project1/db/grades/grade_manager.dart';

Future<void> showInsertDialog(BuildContext context, VoidCallback onGradeAdded) async{
  GradeManager gradeManager = GradeManager();
  TextEditingController studIdCon = TextEditingController();
  TextEditingController gradeCon = TextEditingController();

  return showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Добавить новую Оценку", style: TextStyle(fontSize: 24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: studIdCon,
              decoration: InputDecoration(hintText: "ID Студента"),
            ),
            TextField(
              controller:gradeCon,
              decoration: InputDecoration(hintText: "Добавить Оценку"),
            )
          ],
        ),
        actions: [
          TextButton(
            child: Text("Отмена", style: TextStyle(fontSize: 18)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text("Добавить", style: TextStyle(fontSize: 18)),
            onPressed: () async {
              final studentID = int.parse(studIdCon.text);
              final grade = int.parse(gradeCon.text);
              Grades grades = Grades(studentID: studentID, grades: grade);
              await gradeManager.insertGrade(grades);
              await gradeManager.updateStudentAverageGrade(studentID);
              Navigator.of(context).pop();
              onGradeAdded();
            },
          ),
        ],
      );
    }
  );
}