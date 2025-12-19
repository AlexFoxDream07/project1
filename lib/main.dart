import 'package:flutter/material.dart';
import 'package:project1/tables_screen/student_table.dart';
import 'package:project1/db/database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  // final dbPath = 'E:\\project1\\studentManager1.db';
  // Database db;
  // try {
  //   db = await openDatabase(dbPath);
  // } catch (e) {
  //   print('Ошибка открытия базы данных: $e');
  //   return;
  // }

  Database db =  await DBHelp.instance.initDB();  
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
