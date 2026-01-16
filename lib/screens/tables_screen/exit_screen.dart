import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project1/identification/login.dart';

Future<void> showExitScreen(BuildContext context){
  final _secure = FlutterSecureStorage();

  return showDialog(
    context: context, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Выход из аккаунта'),
        content: Text('Вы уверены что хотите выйти из аккаунта?'),
        actions: [
          TextButton(
            onPressed: () async {
              await _secure.delete(key: 'is_login');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login())
              );
            }, 
            child: Text('Да')
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            }, 
            child: Text('Нет')
          )
        ],
      );
    }
  );
}