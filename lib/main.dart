import 'package:flutter/material.dart';
import 'package:project1/tables_screen/student_table.dart';
import 'package:project1/db/database.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  
  var db = await DBHelp.instance.initDB();
  
  print(db);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const StudentTableScreen(),
    );
  }
}
