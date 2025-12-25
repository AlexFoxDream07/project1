import 'package:flutter/material.dart';
import 'package:project1/db/grades/grades.dart';
import 'package:project1/db/grades/grade_manager.dart';

Future<void> showUpdateDialog (BuildContext context, Grades grades, VoidCallback onGradeUpdate) async{
  TextEditingController gradeCon = TextEditingController(text: grades.grades.toString());
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
              if (grade.isNaN){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Не коректный ввод данных", style: TextStyle(fontSize: 18)))
                );
              }
              else {
                Grades updateGrade = Grades(id: grades.id, studentID: grades.studentID, grades: grade);
                await gradeManager.updateGrade(updateGrade);
                await gradeManager.updateStudentAverageGrade(grades.studentID);
                Navigator.of(context).pop();
                onGradeUpdate();
              }
            },
          )
        ],
      );
    }
  );
}
