import 'package:flutter/material.dart';
import 'package:project1/db/directions/directions.dart';
import 'package:project1/db/directions/direction_manager.dart';

Future<void> showInsertDialog(BuildContext context, VoidCallback onGroupAdded) async{
  TextEditingController nameCon = TextEditingController();
  TextEditingController codeCon = TextEditingController();
  DirectionManager directionManager = DirectionManager();

  return showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Добавить новое Направление", style: TextStyle(fontSize: 24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCon,
              decoration: InputDecoration(hintText: "Название Направления"),
            ),
            TextField(
              controller: codeCon,
              decoration: InputDecoration(hintText: "Код"),
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
              final name = nameCon.text;
              final code = codeCon.text;
              Direction groups = Direction(name: name, code: code);
              await directionManager.insertDir(groups);
              Navigator.of(context).pop();
              onGroupAdded();
            },
          ),
        ],
      );
    }
  );
}