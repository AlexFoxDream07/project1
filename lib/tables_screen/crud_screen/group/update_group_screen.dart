import 'package:flutter/material.dart';
import 'package:project1/db/groups/groups.dart';
import 'package:project1/db/groups/group_manager.dart';

Future<void> showUpdateDialog (BuildContext context, Groups groups, VoidCallback onGroupUpdate) async{
  TextEditingController nameCon = TextEditingController(text: groups.name);
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
              try {
                final name = nameCon.text;
                Groups updateGroup = Groups(id: groups.id, directionId: groups.directionId, name: name, year: groups.year);
                await groupManager.updateGroup(updateGroup);
                Navigator.of(context).pop();
                onGroupUpdate();
              }
              catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Имя не должно быть пустым", style: TextStyle(fontSize: 18)))
                );
              }
            },
          )
        ],
      );
    }
  );
}
