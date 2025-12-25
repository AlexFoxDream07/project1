import 'package:flutter/material.dart';
import 'package:project1/db/students/students.dart';
import 'package:project1/db/students/student_manager.dart';

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
              if (groupId.isNaN || groupId.isNegative){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Не коректный ввод данных", style: TextStyle(fontSize: 18)))
                );
              }
              else if (fullName.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Имя не должно быть пустым", style: TextStyle(fontSize: 18)))
                );
              }
              else {
                Students updateStudents = Students(id: students.id, fullName: fullName, groupId: groupId, averageGrade: students.averageGrade);
                await studentManager.updateStud(updateStudents);
                Navigator.of(context).pop();
                onStudentUpdate();
              }
            },
          )
        ],
      );
    }
  );
}
