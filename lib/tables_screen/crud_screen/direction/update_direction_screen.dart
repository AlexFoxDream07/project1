import 'package:flutter/material.dart';
import 'package:project1/db/directions/directions.dart';
import 'package:project1/db/directions/direction_manager.dart';

Future<void> showUpdateDialog (BuildContext context, Direction directions, VoidCallback onGroupUpdate) async{
  TextEditingController nameCon = TextEditingController(text: directions.name);
  TextEditingController codeCon = TextEditingController(text: directions.code);
  DirectionManager directionManager = DirectionManager();

  return showDialog(
    context: context, 
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Редактирование Направления", style: TextStyle(fontSize: 24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCon,
            ),
            TextField(
              controller: codeCon,
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
            child: Text("Обновить", style: TextStyle(fontSize: 18)),
            onPressed: () async {
              final name = nameCon.text;
              final code = codeCon.text;
              if (name.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Имя не должно быть пустым!", style: TextStyle(fontSize: 18)))
                );
              }
              else if (code.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Код не должен быть пустым!", style: TextStyle(fontSize: 18)))
                );
              }
              else{
                Direction updateDirection = Direction(id: directions.id, name: name, code: code);
                await directionManager.updateDir(updateDirection);
                Navigator.of(context).pop();
                onGroupUpdate();
              }
            },
          )
        ],
      );
    }
  );
}
