import 'dart:io';
import 'package:path_provider/path_provider.dart'; 
import 'package:flutter/material.dart';
import 'package:project1/db/students/student_manager.dart';
import 'package:project1/db/students/students.dart';

Future<void> saveDeptorToFile(BuildContext context) async{
  StudentManager studentManager = StudentManager();
  List<Students> debtors = await studentManager.getStudentsWithLowAverageGrade();

  String text = "Список должников:\n";
  text += "--------------------------------------\n";
    for (var student in debtors) {
      text += "ID: ${student.id}\n";
      text += "ФИО: ${student.fullName}\n";
      text += "Группа: ${student.groupId}\n";
      text += "Средний балл: ${student.averageGrade}\n";
      text += "--------------------------------------\n";
    }

  Directory? downloadsDir;

  downloadsDir = await getDownloadsDirectory();

  if (downloadsDir == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Не удалось получить доступ к папке загрузок.")),
    );
    return;
  }
  String fileName = "debtors.txt";
  File file = File('${downloadsDir.path}/$fileName');

  try{
    await file.writeAsString(text);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Список должников записан в файл: ${file.path}"))
    );
  }
  catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Не удалось записать данные в файл: $e')),
    );
    return;
  }
}