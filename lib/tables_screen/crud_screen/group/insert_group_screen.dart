import 'package:flutter/material.dart';
import 'package:project1/db/groups/groups.dart';
import 'package:project1/db/groups/group_manager.dart';

Future<void> showInsertDialog(BuildContext context, VoidCallback onGroupAdded) async{
  TextEditingController directionCon = TextEditingController();
  TextEditingController nameCon = TextEditingController();
  TextEditingController yaerCon = TextEditingController();
  GroupManager groupManager = GroupManager();

  return showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Добавить новую Группу", style: TextStyle(fontSize: 24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: directionCon,
              decoration: InputDecoration(hintText: "№ Направления"),
            ),
            TextField(
              controller: nameCon,
              decoration: InputDecoration(hintText: "Название группы"),
            ),
            TextField(
              controller: yaerCon,
              decoration: InputDecoration(hintText: "Год"),
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
                try {
                  final directionId = int.parse(directionCon.text);
                  final name = nameCon.text;
                  final year = yaerCon.text;
                  Groups groups = Groups(directionId: directionId, name: name, year: year);
                  if (await groupManager.isIDexist(directionId) == true){
                    await groupManager.insertGroup(groups);
                    Navigator.of(context).pop();
                    onGroupAdded();
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Несуществующее направление", style: TextStyle(fontSize: 18)))
                    );
                  }
                }
                catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Некорректный ввод данных", style: TextStyle(fontSize: 18)))
                  );
                }
            },
          ),
        ],
      );
    }
  );
}