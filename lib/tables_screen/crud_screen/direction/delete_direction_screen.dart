import 'package:flutter/material.dart';
import 'package:project1/db/directions/directions.dart';
import 'package:project1/db/directions/direction_manager.dart';

Future<void> showDeleteDialog(BuildContext context, Directions directions, VoidCallback onDirectionDelete) async {
  DirectionManager directionManager = DirectionManager();
  return showDialog(
    context: context, 
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Удаление Группы", style: TextStyle(fontSize: 24)),
        content: Column(
          children: [
            Text("Вы уверены что хотите удалить даннное направление?"),
            Text("Имя: ${directions.name}")
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
              await directionManager.deleteGrDir(directions);
              onDirectionDelete();
              Navigator.of(context).pop();
            },
          )
        ],
      );
    }
  );
}