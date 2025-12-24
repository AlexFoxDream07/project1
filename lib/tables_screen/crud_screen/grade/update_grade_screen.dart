import 'package:flutter/material.dart';
import 'package:project1/db/tables.dart';
import 'package:project1/db/grade_manager.dart';

Future<void> showUpdateDialog (BuildContext context, Grades grades, VoidCallback onGradeUpdate) async{
  TextEditingController gradeCon = TextEditingController();
  GradeManager gradeManager = GradeManager();

  return showDialog(
    context: context, 
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Редактирование Оценок", style: TextStyle(fontSize: 24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: gradeCon,
              decoration: InputDecoration(hintText: "Изменить Оценку"),
            ),
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
            child: Text("Обновить", style: TextStyle(fontSize: 18)),
            onPressed: () async {
              final grade = int.parse(gradeCon.text);
              Grades updateGrade = Grades(id: grades.id, studentID: grades.studentID, grades: grade);
              await gradeManager.updateGrade(updateGrade);
              Navigator.of(context).pop();
              onGradeUpdate();
            },
          )
        ],
      );
    }
  );
}
