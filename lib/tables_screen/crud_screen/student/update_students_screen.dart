import 'package:flutter/material.dart';
import 'package:project1/db/tables.dart';
import 'package:project1/db/student_manager.dart';

Future<void> showUpdateDialog (BuildContext context, Students students, VoidCallback onStudentUpdate) async{
  TextEditingController fullNameCon = TextEditingController(text: students.fullName);
  TextEditingController grIdCon = TextEditingController(text: students.groupId.toString());
  StudentManager studentManager = StudentManager();

  return showDialog(
    context: context, 
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Редактирование Студента", style: TextStyle(fontSize: 24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: fullNameCon,
              decoration: InputDecoration(hintText: "Новое ФИО"),
            ),
            TextField(
              controller: grIdCon,
              decoration: InputDecoration(hintText: "Новая Группа"),
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
              final fullName = fullNameCon.text;
              final groupId = int.tryParse(grIdCon.text) ?? students.groupId;
              Students updateStudents = Students(id: students.id, fullName: fullName, groupId: groupId);
              await studentManager.updateStud(updateStudents);
              Navigator.of(context).pop();
              onStudentUpdate();
            },
          )
        ],
      );
    }
  );
}
