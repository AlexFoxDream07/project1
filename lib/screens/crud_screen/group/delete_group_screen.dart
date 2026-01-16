import 'package:flutter/material.dart';
import 'package:project1/db/groups/groups.dart';
import 'package:project1/db/groups/group_manager.dart';

Future<void> showDeleteDialog(BuildContext context, Groups groups, VoidCallback onGroupDelete) async {
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
              onGroupDelete();
              Navigator.of(context).pop();
            },
          )
        ],
      );
    }
  );
}