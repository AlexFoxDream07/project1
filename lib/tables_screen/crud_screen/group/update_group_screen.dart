import 'package:flutter/material.dart';
import 'package:project1/db/tables.dart';
import 'package:project1/db/group_manager.dart';

Future<void> showUpdateDialog (BuildContext context, Groups groups, VoidCallback onGroupUpdate) async{
  TextEditingController nameCon = TextEditingController();
  GroupManager groupManager = GroupManager();

  return showDialog(
    context: context, 
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Редактирование Группы", style: TextStyle(fontSize: 24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCon,
              decoration: InputDecoration(hintText: "Новое Название"),
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
              final name = nameCon.text;
              Groups updateGroup = Groups(id: groups.id, directionId: groups.directionId, name: name, yaer: groups.yaer);
              await groupManager.updateGroup(updateGroup);
              Navigator.of(context).pop();
              onGroupUpdate();
            },
          )
        ],
      );
    }
  );
}
