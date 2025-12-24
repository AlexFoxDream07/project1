import 'package:flutter/material.dart';
import 'package:project1/db/tables.dart';
import 'package:project1/db/grade_manager.dart';

Future<void> showDeleteDialog(BuildContext context, Grades grades, VoidCallback onStudentDelete) async {
  GradeManager gradeManager = GradeManager();

  return showDialog(
    context: context, 
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Удаление Оценки", style: TextStyle(fontSize: 24)),
        content: Column(
          children: [
            Text("Вы уверены что хотите удалить данную оценку у студента?")
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Отмена', style: TextStyle(fontSize: 18)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text("Удалить", style: TextStyle(fontSize: 18)),
            onPressed: () async {
              await gradeManager.deleteGrade(grades);
              await gradeManager.updateStudentAverageGrade(grades.studentID);
              onStudentDelete();
              Navigator.of(context).pop();
            },
          )
        ],
      );
    }
  );
}