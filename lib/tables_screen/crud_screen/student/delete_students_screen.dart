import 'package:flutter/material.dart';
import 'package:project1/db/tables.dart';
import 'package:project1/db/student_manager.dart';

Future<void> showDeleteDialog(BuildContext context, Students student, VoidCallback onStudentDelete) async {
  StudentManager studentManager = StudentManager();

  return showDialog(
    context: context, 
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Удаление Студента", style: TextStyle(fontSize: 24)),
        content: Column(
          children: [
            Text("Вы уверены что хотите удалить данного пользователя?"),
            Text("Имя: ${student.fullName}")
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
              await studentManager.deleteStud(student);
              onStudentDelete();
              Navigator.of(context).pop();
            },
          )
        ],
      );
    }
  );
}