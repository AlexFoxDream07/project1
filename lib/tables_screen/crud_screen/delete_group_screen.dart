import 'package:flutter/material.dart';
import 'package:project1/db/tables.dart';
import 'package:project1/db/group_manager.dart';

Future<void> showDeleteDialog(BuildContext context, Groups groups, VoidCallback onStudentDelete) async {
  GroupManager groupManager = GroupManager();
  return showDialog(
    context: context, 
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Удаление Группы", style: TextStyle(fontSize: 24)),
        content: Column(
          children: [
            Text("Вы уверены что хотите удалить данную группу?"),
            Text("Имя: ${groups.name}")
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
              await groupManager.deleteGrGroup(groups);
              onStudentDelete();
              Navigator.of(context).pop();
            },
          )
        ],
      );
    }
  );
}