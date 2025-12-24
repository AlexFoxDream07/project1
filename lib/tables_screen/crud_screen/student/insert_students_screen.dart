import 'package:flutter/material.dart';
import 'package:project1/db/tables.dart';
import 'package:project1/db/student_manager.dart';

Future<void> showInsertDialog(BuildContext context, VoidCallback onStudentAdded) async{
  TextEditingController fullNameCon = TextEditingController();
  TextEditingController grIdCon = TextEditingController();
  StudentManager studentManager = StudentManager();

  return showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Добавить нового студента", style: TextStyle(fontSize: 24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: fullNameCon,
              decoration: InputDecoration(hintText: "ФИО"),
            ),
            TextField(
              controller: grIdCon,
              decoration: InputDecoration(hintText: "№ Группы"),
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
              final fullName = fullNameCon.text;
              final groupId = int.parse(grIdCon.text);
              Students students = Students(fullName: fullName, groupId: groupId, averageGrade: 0.0);
              await studentManager.insertStud(students);
              Navigator.of(context).pop();
              onStudentAdded();
            },
          ),
        ],
      );
    }
  );
}